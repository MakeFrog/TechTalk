import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_event.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/topic_list_provider.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/widgets/topic_card.dart';
import 'package:techtalk/presentation/widgets/base/base_statless_page.dart';

class InterviewTopicSelectPage extends BaseStatelessWidget {
  const InterviewTopicSelectPage({super.key});

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) => AppBar();

  @override
  Widget buildPage(BuildContext context) => const _Body();
}

class _Body extends HookWidget with InterviewTopicSelectEvent {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTopic = useState<InterviewTopic?>(null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoMessage(),
        _buildTopicListView(selectedTopic),
        _buildNextButton(selectedTopic),
        const Gap(16),
      ],
    );
  }

  Widget _buildInfoMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'AI 면접을 진행할\n주제를 알려주세요',
        style: AppTextStyle.headline1,
      ),
    );
  }

  Widget _buildTopicListView(ValueNotifier<InterviewTopic?> selectedTopic) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Consumer(
          builder: (context, ref, child) {
            final topicsAsync = ref.watch(topicListProvider);

            return topicsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Text('$error'),
              data: (data) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final topic = data[index];
                    final isSelected = topic == selectedTopic.value;

                    return TopicCard(
                      topic: topic,
                      isSelected: isSelected,
                      onTap: () {
                        if (isSelected) {
                          selectedTopic.value = null;
                        } else {
                          selectedTopic.value = topic;
                        }
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNextButton(ValueNotifier<InterviewTopic?> selectedTopic) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton(
            onPressed: selectedTopic.value != null
                ? () => onTapNext(ref, selectedTopic.value!)
                : null,
            child: const Center(
              child: Text('다음'),
            ),
          ),
        );
      },
    );
  }
}
