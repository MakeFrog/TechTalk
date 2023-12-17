import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_event.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_topic_provider.dart';
import 'package:techtalk/presentation/providers/topic/interviewable_topics_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/interview_topic_card.dart';

class InterviewTopicSelectPage extends BasePage {
  const InterviewTopicSelectPage({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(20),
          Text(
            'AI 면접을 진행할\n주제를 알려주세요',
            style: AppTextStyle.headline1,
          ),
          _TopicListView(),
          _NextButton(),
        ],
      ),
    );
  }
}

class _TopicListView extends ConsumerWidget with InterviewTopicSelectEvent {
  const _TopicListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 11,
      mainAxisSpacing: 12,
    );
    final selectedTopic = ref.watch(selectedInterviewTopicProvider);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final topicList = ref.watch(interviewableTopicsProvider);
            return GridView.builder(
              gridDelegate: gridDelegate,
              itemCount: topicList.length,
              itemBuilder: (context, index) {
                final topic = topicList[index];
                final isSelected = selectedTopic == topic;
                return InterviewTopicCard(
                  topic: topic,
                  isSelected: isSelected,
                  onTap: () => onTapTopicCard(
                    ref,
                    topic: topic,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _NextButton extends ConsumerWidget with InterviewTopicSelectEvent {
  const _NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTopic = ref.watch(selectedInterviewTopicProvider);
    return FilledButton(
      onPressed:
          selectedTopic != null ? () => routeToQuestionCountSelect(ref) : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}
