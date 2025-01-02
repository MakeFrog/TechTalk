import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/app/util/app_formatter.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/widgets/common/chip/dark_tranparent_chip.dart';
import 'package:techtalk/presentation/widgets/common/chip/outlined_chip.dart';

///
/// 유튜브 콘텐츠 항목 뷰
///

class YoutubeContentItemView extends StatelessWidget {
  const YoutubeContentItemView({
    super.key,
    required this.thumbnailImgUrl,
    required this.title,
    required this.channelName,
    this.videoDuration,
    this.questionCount,
    this.jobGroups = const [],
    this.skills = const [],
  });

  final String thumbnailImgUrl;
  final String title;
  final String channelName;
  final Duration? videoDuration;
  final int? questionCount;
  final List<JobGroup> jobGroups;
  final List<SkillEntity> skills;

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
                  child: Image.network(
                    thumbnailImgUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Row(
                    children: [
                      if (videoDuration != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: DarkTransparentChip(
                            label: AppFormatter.formatDuration(
                              videoDuration!,
                            ),
                          ),
                        ),
                      if (videoDuration != null)
                        DarkTransparentChip(label: '질문 $questionCount개'),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: AppColor.of.white,
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                minHeight: AppSize.ratioWidth(76),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.title1,
                    maxLines: 2,
                  ),
                  const Gap(2),
                  Text(
                    channelName,
                    maxLines: 1,
                    style: AppTextStyle.body2.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: HookBuilder(
                      builder: (context) {
                        List<YoutubeContentCategory> categories = useMemoized(
                          () => [
                            ...jobGroups.map(YoutubeContentCategory.fromJob),
                            ...skills.map(YoutubeContentCategory.fromSkill)
                          ]..shuffle(),
                        );
                        return LayoutBuilder(
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

                              indicatorWidth =
                                  indicatorTextPainter.width + indicatorPadding;
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
                                      left: 2,
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
                                  width: indicatorWidth,
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
                        );
                      },
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
