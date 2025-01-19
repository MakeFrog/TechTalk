import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/channel_detail_state.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/main/widgets/youtube_pagination_indicator_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/grid_view/expandable_youtube_content_grid_view.dart';
import 'package:techtalk/presentation/widgets/common/image/round_profile_image.dart';

class ChannelDetailPage extends BasePage with ChannelDetailState {
  const ChannelDetailPage(this.channel, {super.key});

  final ChannelEntity channel;

  @override
  Override? get argProviderOverrides =>
      channelDetailRouteArgProvider.overrideWithValue(channel);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 배너 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 343 / 105,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://yt3.googleusercontent.com/-KbvrOwXU-FSD3QioqN-IBNWfCSyZkVHqqKmXRuQ0eR3ucp0NKaDbp639PKsPklh8e8Xcm7SWg=w2560-fcrop64=1,00005a57ffffa5a8-k-c0xffffffff-no-nd-rj",
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(24),
            // 채널 정보 섹션
            Row(
              children: [
                RoundProfileImg(
                  size: 64,
                  imgUrl: channel.logoUrl,
                ),
                const Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.name,
                      style: AppTextStyle.headline2,
                    ),
                    const Gap(2),
                    Text(
                      '구독자 수 999만명',
                      style: AppTextStyle.body3.copyWith(
                        color: AppColor.of.gray4,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Gap(24),
            // 콘텐츠 목록 섹션
            PagedListView<DocumentSnapshot<YoutubeMainModel>?,
                YoutubeContentOverviewEntity>(
              shrinkWrap: true, // 스크롤 뷰 안에 맞춤
              physics: const NeverScrollableScrollPhysics(), // 내부 스크롤 비활성화
              pagingController: pagingController(ref),
              builderDelegate:
                  PagedChildBuilderDelegate<YoutubeContentOverviewEntity>(
                itemBuilder: (context, item, index) {
                  // 데이터 리스트
                  final itemList = pagingController(ref).itemList ?? [];

                  // 현재 페이지에 있는 아이템의 개수 확인
                  final firstIndex = index * 2;
                  final secondIndex = firstIndex + 1;

                  // 첫 번째 아이템
                  final firstItem = firstIndex < itemList.length
                      ? itemList[firstIndex]
                      : null;

                  // 두 번째 아이템
                  final secondItem = secondIndex < itemList.length
                      ? itemList[secondIndex]
                      : null;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 첫 번째 아이템
                        Expanded(
                          child: firstItem != null
                              ? _buildItem(firstItem)
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(width: 8), // 열 간 간격
                        // 두 번째 아이템 (존재하지 않을 경우 빈 공간)
                        Expanded(
                          child: secondItem != null
                              ? _buildItem(secondItem)
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                },
                firstPageProgressIndicatorBuilder: (_) =>
                    ExpandableYoutubeContentGridView.createSkeleton(
                  showSubtitleSkeleton: false,
                ),
                newPageProgressIndicatorBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                noItemsFoundIndicatorBuilder: (context) =>
                    _buildExceptionView(ref, '결과가 없습니다'),
                firstPageErrorIndicatorBuilder: (context) =>
                    _buildExceptionView(ref, '영상을 불러오지 못했어요'),
              ),
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }

  /// 호출실패
  Widget _buildExceptionView(WidgetRef ref, String label) {
    return Column(
      children: [
        Gap(AppSize.ratioHeight(120)),
        Center(
          child: YoutubePaginationIndicatorView(
            setFlexRatio: false,
            title: '영상을 불러오지 못했어요',
            description: '일시적이 오류일 수 있으니 다시 시도해보세요',
            btnText: '다시 시도',
            onBtnTapped: () {
              pagingController(ref).refresh();
            },
          ),
        ),
      ],
    );
  }

  /// 각 아이템을 빌드하는 메서드
  Widget _buildItem(YoutubeContentOverviewEntity item) {
    return GestureDetector(
      onTap: () {
        // 아이템 클릭 처리
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 썸네일
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 167.54 / 94, // 썸네일 비율
              child: Image.network(
                item.thumbnailImgUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * (94 / 167.54),
                    child: const SkeletonBox(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 콘텐츠 제목
          Text(
            item.contentsTitle,
            style: AppTextStyle.body1,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
