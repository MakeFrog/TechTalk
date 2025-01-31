import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/app/util/app_formatter.dart';
import 'package:techtalk/core/index.dart';

import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';

///
/// 유튜브 콘텐츠 항목 뷰, 내 영상 학습에 표시되는 작은 버전
///

class YoutubeContentSmallItemView extends StatelessWidget {
  const YoutubeContentSmallItemView({
    super.key,
    required this.videoId,
    required this.thumbnailImgUrl,
    required this.title,
    required this.channelName,
    this.videoDuration,
    this.questionCount,
    this.isLoaded = true,
    this.showCategorySkeleton = true,
    this.heroEnabled = false,
    this.onTapDeleteButton,
  });

  final String thumbnailImgUrl;
  final String title;
  final String channelName;
  final Duration? videoDuration;
  final int? questionCount;

  final bool isLoaded;
  final bool showCategorySkeleton;
  final bool heroEnabled;
  final String videoId;
  final void Function()? onTapDeleteButton;

  factory YoutubeContentSmallItemView.createSkeleton(
          {bool exposeCategories = true}) =>
      YoutubeContentSmallItemView(
        videoId: '',
        thumbnailImgUrl: '',
        title: '',
        channelName: '',
        isLoaded: false,
        showCategorySkeleton: exposeCategories,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 343 / 192,
              child: isLoaded
                  ? Image.network(
                      thumbnailImgUrl,
                      width: double.infinity,
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        return SizedBox(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 120),
                            child: loadingProgress == null
                                ? child
                                : const SkeletonBox(),
                          ),
                        );
                      },
                      fit: BoxFit.fitWidth,
                    )
                  : const SkeletonBox(),
            ),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 타이틀 + 닫기 버튼
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.title2.copyWith(
                                color: AppColor.of.black,
                              ),
                            ),
                          ),
                          // 버튼과 텍스트가 너무 가까울 수 있으니 여백 추가
                          const SizedBox(width: 15),
                          if (onTapDeleteButton != null)
                            BounceTapper(
                              onTap: onTapDeleteButton,
                              shrinkScaleFactor: 1,
                              highlightColor: Colors.transparent,
                              child: SvgPicture.asset(
                                Assets.iconsRoundedClose,
                                width: 20,
                              ),
                            ),
                        ],
                      ),
                      const Gap(2),
                      // 채널명
                      Text(
                        channelName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.body3.copyWith(
                          color: AppColor.of.gray5,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLoaded)
                  Row(
                    children: [
                      if (videoDuration != null)
                        Text(
                          AppFormatter.formatDurationLanguageFormat(
                            videoDuration!,
                          ),
                          style: AppTextStyle.alert1.copyWith(
                            color: AppColor.of.gray4,
                          ),
                        ),

                      // videoDuration과 questionCount 둘 다 null이 아닐 때만 표시
                      if (videoDuration != null && questionCount != null)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: 1,
                          color: AppColor.of.gray2,
                        ),

                      if (videoDuration != null)
                        Text(
                          '질문 $questionCount개',
                          style: AppTextStyle.alert1.copyWith(
                            color: AppColor.of.gray4,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
