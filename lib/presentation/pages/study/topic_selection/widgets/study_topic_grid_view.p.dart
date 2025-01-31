part of '../study_topic_selection_page.dart';

class _StudyTopicGridView extends ConsumerWidget
    with StudyTopicSelectionState, StudyTopicSelectionEvent {
  const _StudyTopicGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
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
    );
  }
}
