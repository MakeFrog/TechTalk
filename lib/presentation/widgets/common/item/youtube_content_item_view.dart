import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/app/util/app_formatter.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/chip/dark_tranparent_chip.dart';
import 'package:techtalk/presentation/widgets/common/chip/outlined_chip.dart';

///
/// 유튜브 콘텐츠 항목 뷰
///

class YoutubeContentItemView extends StatelessWidget {
  const YoutubeContentItemView({
    super.key,
    required this.videoId,
    required this.thumbnailImgUrl,
    required this.title,
    required this.channelName,
    this.videoDuration,
    this.questionCount,
    this.jobGroups = const [],
    this.skills = const [],
    this.isLoaded = true,
    this.showCategorySkeleton = true,
    this.heroEnabled = false,
  });

  final String thumbnailImgUrl;
  final String title;
  final String? channelName;
  final Duration? videoDuration;
  final int? questionCount;
  final List<JobGroupEntity> jobGroups;
  final List<SkillEntity> skills;

  final bool isLoaded;
  final bool showCategorySkeleton;
  final bool heroEnabled;
  final String videoId;

  factory YoutubeContentItemView.createSkeleton(
          {bool exposeCategories = true}) =>
      YoutubeContentItemView(
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
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.of.gray1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 343 / 192,
                  child: isLoaded
                      ? Image.network(
                          thumbnailImgUrl,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
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
                if (isLoaded)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Row(
                      children: [
                        if (videoDuration != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: DarkTransparentChip(
                              label: AppFormatter.formatDurationTommssOrHHmmss(
                                videoDuration!,
                              ),
                            ),
                          ),
                        if (questionCount != null)
                          DarkTransparentChip(label: '질문 $questionCount개'),
                      ],
                    ),
                  ),
              ],
            ),
            Container(
              color: AppColor.of.white,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoaded)
                    SizedBox(
                      child: Text(
                        title,
                        style: AppTextStyle.title1,
                        maxLines: 2,
                      ),
                    )
                  else
                    SkeletonBox(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      height: 18,
                      width: AppSize.ratioWidth(162),
                    ),
                  const Gap(2),
                  if (isLoaded && channelName != null)
                    Text(
                      channelName!,
                      maxLines: 1,
                      style: AppTextStyle.body2.copyWith(
                        color: AppColor.of.gray3,
                      ),
                    )
                  else
                    const SkeletonBox(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      height: 16,
                      width: 60,
                    ),
                  if (isLoaded)
                    HookBuilder(
                      builder: (context) {
                        List<YoutubeContentCategory> categories = useMemoized(
                          () => [
                            ...jobGroups.map(YoutubeContentCategory.fromJob),
                            ...skills.map(YoutubeContentCategory.fromSkill)
                          ]..shuffle(),
                        );
                        if (categories.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double remainingWidth =
                                    constraints.maxWidth; // 부모 컨테이너의 너비
                                const double spacing = 4; // Chip 간의 간격
                                const double indicatorPadding =
                                    20; // +n 인디케이터 내부 여백 포함

                                List<Widget> visibleChips = [];
                                int hiddenCount = 0;

                                // 숨겨진 개수 인디케이터의 초기값 설정
                                double indicatorWidth = 0;
                                if (categories.isNotEmpty) {
                                  final TextPainter indicatorTextPainter =
                                      TextPainter(
                                    text: TextSpan(
                                      text: '+999', // 초기 예상 텍스트로 최대 길이를 잡음
                                      style: AppTextStyle.alert1,
                                    ),
                                    textDirection: TextDirection.ltr,
                                  )..layout();

                                  indicatorWidth = indicatorTextPainter.width +
                                      indicatorPadding;
                                }

                                for (final category in categories) {
                                  final TextPainter textPainter = TextPainter(
                                    text: TextSpan(
                                      text: category.name,
                                      style: AppTextStyle.alert1,
                                    ),
                                    textDirection: TextDirection.ltr,
                                  )..layout();

                                  final double chipWidth =
                                      textPainter.width + 16; // Chip 내부 여백 포함

                                  // 인디케이터를 고려한 남은 공간 확인
                                  if (remainingWidth >=
                                      chipWidth + spacing + indicatorWidth) {
                                    visibleChips.add(
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: spacing,
                                        ),
                                        child: OutlinedChip(
                                          label: category.name,
                                        ),
                                      ),
                                    );
                                    remainingWidth -= chipWidth + spacing;
                                  } else {
                                    hiddenCount =
                                        categories.length - visibleChips.length;
                                    break;
                                  }
                                }

                                // 숨겨진 개수 인디케이터 추가
                                if (hiddenCount > 0) {
                                  visibleChips.add(
                                    Container(
                                      height: 25,
                                      width: indicatorWidth - 10,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '+$hiddenCount',
                                        style: AppTextStyle.alert1.copyWith(
                                          color: AppColor.of.gray3,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Wrap(
                                  children: visibleChips,
                                );
                              },
                            ),
                          );
                        } else {
                          return const EmptyBox();
                        }
                      },
                    ),
                  if (!isLoaded && showCategorySkeleton)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          ...List.generate(
                            4,
                            (index) => const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: SkeletonBox(
                                height: 25,
                                width: 52,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
