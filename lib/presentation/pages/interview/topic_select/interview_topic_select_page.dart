import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/section/interview_topic_card.dart';

class InterviewTopicSelectPage extends BasePage {
  const InterviewTopicSelectPage({
    super.key,
    required this.type,
  });

  final InterviewType type;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final selectedTopicState = useState<List<TopicEntity>>([]);

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
          _TopicListView(
            type: type,
            selectedTopicState: selectedTopicState,
          ),
          _NextButton(
            type: type,
            selectedTopics: selectedTopicState.value,
          ),
        ],
      ),
    );
  }
}

class _TopicListView extends ConsumerWidget with InterviewTopicSelectEvent {
  _TopicListView({
    Key? key,
    required this.type,
    required this.selectedTopicState,
  }) : super(key: key);

  final InterviewType type;
  final ValueNotifier<List<TopicEntity>> selectedTopicState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 11,
      mainAxisSpacing: 12,
    );

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final topicList = getTopicsUseCase().getOrThrow();

            return GridView.builder(
              gridDelegate: gridDelegate,
              itemCount: topicList.length,
              itemBuilder: (context, index) {
                final topic = topicList[index];
                final isSelected = selectedTopicState.value.contains(topic);

                return InterviewTopicCard(
                  topic: topic,
                  isSelected: isSelected,
                  onTap: () => onTapTopic(
                    type,
                    selectedTopicState,
                    topic,
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
  const _NextButton({
    Key? key,
    required this.type,
    required this.selectedTopics,
  }) : super(key: key);

  final InterviewType type;
  final List<TopicEntity> selectedTopics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: selectedTopics.isNotEmpty
          ? () => routeToQuestionCountSelect(
                ref,
                type: type,
                topic: selectedTopics,
              )
          : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}
