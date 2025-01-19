import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/study_topic_selection_state.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/study_topic_selection_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/foldable_app_bar.dart';
import 'package:techtalk/presentation/widgets/section/study_topic_card.dart';

class StudyTopicSelectionPage extends BasePage
    with StudyTopicSelectionState, StudyTopicSelectionEvent {
  const StudyTopicSelectionPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return SingleChildScrollView(
      controller: scrollController(ref),
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(8),
            BounceTapper(
              onTap: () {
                onWrongAnswerCardTapped(ref);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.of.red1,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 187,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '오답노트',
                                  style: AppTextStyle.headline2.copyWith(
                                    color: AppColor.of.red2,
                                  ),
                                ),
                                const Gap(2),
                                SvgPicture.asset(
                                  Assets.iconsRightAlignedRightArrow,
                                )
                              ],
                            ),
                            const Gap(4),
                            Text(
                              '오답 복습을 통해\n실력을 증진하세요!',
                              style: AppTextStyle.body3.copyWith(
                                color: AppColor.of.gray5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 156,
                      child: SvgPicture.asset(
                        Assets.iconsMistakeNoteIllust,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 12,
              ),
              itemCount: topics(ref).length,
              itemBuilder: (context, index) {
                final topic = topics(ref)[index];

                return StudyTopicCard(
                  topic: topic,
                  onTap: () => onTapCard(
                    ref,
                    topic: topic,
                  ),
                  scrollController: scrollController(ref),
                );
              },
            ),
            const Gap(120),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return FoldableAppBar(
      title: tr(LocaleKeys.gnb_learning),
      scrollController: scrollController(ref),
      animatedPosition: 20,
    );
  }
}
