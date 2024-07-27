import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_event.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_state.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_interview_topics_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/animated_app_bar.dart';
import 'package:techtalk/presentation/widgets/section/interview_topic_card.dart';

class InterviewTopicSelectPage extends BasePage with InterviewTopicSelectState {
  const InterviewTopicSelectPage({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        controller: scrollController(ref),
        shrinkWrap: true,
        children: <Widget>[
          const Gap(20),
          Text(
            tr(LocaleKeys.interview_selectInterviewTopic),
            style: AppTextStyle.headline1,
          ),
          if (interviewType(ref).isPractical)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                tr(
                  LocaleKeys.interview_maxFourQuestions,
                  namedArgs: {
                    'number': '${SelectedInterviewTopics.limitCount + 1}',
                  },
                ),
                style: AppTextStyle.body1.copyWith(
                  color: AppColor.of.gray4,
                ),
              ),
            ),
          const Gap(24),
          _TopicListView(),
          const Gap(52),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AnimatedAppBar(
      title: tr(LocaleKeys.undefined_interviewTopic),
      scrollController: scrollController(ref),
      opacityPosition: 86,
    );
  }

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return const _NextButton();
  }

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;
}

class _TopicListView extends ConsumerWidget
    with InterviewTopicSelectState, InterviewTopicSelectEvent {
  _TopicListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 11,
      mainAxisSpacing: 12,
    );

    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      child: Consumer(
        builder: (context, ref, child) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: gridDelegate,
            itemCount: topics(ref).length,
            itemBuilder: (context, index) {
              final topic = topics(ref)[index];

              return InterviewTopicCard(
                topic: topics(ref)[index],
                isSelected: selectedTopics(ref).contains(topic),
                onTap: () => onTopicItemTapped(
                  ref,
                  topic: topic,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NextButton extends ConsumerWidget
    with InterviewTopicSelectState, InterviewTopicSelectEvent {
  const _NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.to.bottomInset == 0 ? 16 : 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      child: FilledButton(
        onPressed: isStepBtnActivate(ref)
            ? () => routeToQuestionCountSelect(ref)
            : null,
        child: Center(
          child: Text(tr(LocaleKeys.common_next)),
        ),
      ),
    );
  }
}
