part of '../study_topic_selection_page.dart';

class _Scaffold extends ConsumerWidget with StudyTopicSelectionState {
  const _Scaffold({
    super.key,
    required this.wrongAnswerNoteCard,
    required this.studyTopicGridView,
  });

  final Widget wrongAnswerNoteCard;
  final Widget studyTopicGridView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      controller: scrollController(ref),
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(8),
            wrongAnswerNoteCard,
            studyTopicGridView,
            const Gap(120),
          ],
        ),
      ),
    );
  }
}
