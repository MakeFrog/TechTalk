import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_event.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_topic_provider.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/topic_list_provider.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/widgets/topic_card.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/widgets/topic_grid_view_builder.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class InterviewTopicSelectPage extends BasePage with InterviewTopicSelectEvent {
  const InterviewTopicSelectPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(20),
          _buildInfoMessage(),
          const _TopicListView(),
          const _NextButton(),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();

  Widget _buildInfoMessage() {
    return Text(
      'AI 면접을 진행할\n주제를 알려주세요',
      style: AppTextStyle.headline1,
    );
  }
}

class _NextButton extends ConsumerWidget with InterviewTopicSelectEvent {
  const _NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: ref.watch(selectedTopicProvider) != null
          ? () {
              routeToQuestionCountSelect(ref);
            }
          : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}

class _TopicListView extends ConsumerWidget {
  const _TopicListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final topicListAsync = ref.watch(topicListProvider);

            return topicListAsync.when(
              data: (data) {
                return TopicGridViewBuilder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final topic = data[index];

                    return TopicCard(
                      topic: topic,
                      isSelected: ref.watch(selectedTopicProvider) == topic,
                      onTap: () {
                        ref
                            .read(selectedTopicProvider.notifier)
                            .onTopicSelected(topic);
                      },
                    );
                  },
                );
              },
              loading: () {
                return TopicGridViewBuilder(
                  itemCount: 10,
                  itemBuilder: (_, __) {
                    return TopicCard.createSkeleton();
                  },
                );
              },
              error: (error, stackTrace) => Text('$error'),
            );
          },
        ),
      ),
    );
  }
}
