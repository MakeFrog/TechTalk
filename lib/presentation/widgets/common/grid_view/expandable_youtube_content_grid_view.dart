import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/helper/cached_image_size_extension.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';

///
/// 자식의 높이에 따라 cell의 높의가 동적을 설정되는 그리드뷰
/// 유튜브 콘텐츠 리스트 2열로 보여줄 때 사용
///
class ExpandableYoutubeContentGridView extends StatelessWidget {
  const ExpandableYoutubeContentGridView({
    super.key,
    required this.video,
    required this.onTap,
    this.isLoaded = true,
    this.showSubtitleSkeleton = true,
  });

  final List<VideoOverviewEntity>? video;
  final void Function(VideoOverviewEntity video) onTap;
  final bool isLoaded;
  final bool showSubtitleSkeleton;

  factory ExpandableYoutubeContentGridView.createSkeleton(
          {bool showSubtitleSkeleton = false}) =>
      ExpandableYoutubeContentGridView(
        video: const [],
        onTap: (_) {},
        isLoaded: false,
        showSubtitleSkeleton: showSubtitleSkeleton,
      );

  @override
  Widget build(BuildContext context) {
    if (isLoaded || (video?.isNotEmpty ?? true)) {
      final rowSizes = video?.isNotEmpty ?? true
          ? List.generate(
              (video?.length ?? 10 / 2).ceil(), // 반올림으로 row 개수 계산
              (_) => auto,
            )
          : [auto]; // 기본값 설정

      return SizedBox(
        width: double.infinity, // 부모 위젯의 너비를 제한
        child: LayoutGrid(
          columnSizes: const [FlexibleTrackSize(1), FlexibleTrackSize(1)],
          rowSizes: rowSizes,
          // 수정된 부분
          rowGap: 12,
          columnGap: 8,
          children: [
            for (var i = 0; i < (video?.length ?? 10); i++)
              Builder(
                builder: (context) {
                  final content = video?[i];
                  return GestureDetector(
                    onTap: () {
                      if (content == null) return;
                      onTap(content);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: content != null
                                  ? AspectRatio(
                                      aspectRatio: 167.54 / 94,
                                      child: Image.network(
                                        content.thumbnailImgUrl ?? '',
                                        fit: BoxFit.cover,
                                        cacheWidth:
                                            ((AppSize.screenWidth - 40) / 2)
                                                .cacheSize(context),
                                        errorBuilder: (_, __, ___) {
                                          return SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                (94 / 167.54),
                                            child: const SkeletonBox(),
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const SkeletonBox();
                                        },
                                      ),
                                    )
                                  : const AspectRatio(
                                      aspectRatio: 167.54 / 94,
                                      child: SkeletonBox())),
                        ),
                        const SizedBox(height: 8),
                        if (content != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              content.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.body1,
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: SkeletonBox(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              width: AppSize.ratioWidth(110),
                              height: 16,
                            ),
                          ),
                        if (content != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              content.channelName,
                              style: AppTextStyle.alert2.copyWith(
                                color: AppColor.of.gray3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: SkeletonBox(
                              width: AppSize.ratioWidth(40),
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              height: 13,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      );
    } else {
      return _buildRelatedGridViewSkeleton();
    }
  }

  /// 그리드뷰 스켈레톤
  Widget _buildRelatedGridViewSkeleton() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 167.54 / 138,
        crossAxisCount: 2, // 셀의 최대 너비
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const AspectRatio(
                aspectRatio: 167.54 / 94,
                child: SkeletonBox(),
              ),
            ),
            const MaxGap(8),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: SkeletonBox(
                padding: const EdgeInsets.symmetric(vertical: 2),
                width: AppSize.ratioWidth(110),
                height: 16,
              ),
            ),
            if (showSubtitleSkeleton)
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: SkeletonBox(
                  width: AppSize.ratioWidth(40),
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  height: 13,
                ),
              ),
          ],
        );
      },
    );
  }
}
