part of '../wrong_answer_note_page.dart';

class _EmptyListPlaceholder extends ConsumerWidget
    with WrongAnswerNoteState, WrongAnswerNoteEvent {
  const _EmptyListPlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr(LocaleKeys.mistakeNote_noMistakeRecords),
            style: AppTextStyle.body2,
          ),
          const Gap(12),
          Center(
            child: BounceTapper(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  foregroundColor: AppColor.of.brand3,
                  backgroundColor: AppColor.of.blue1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 13,
                  ),
                ),
                onPressed: () {
                  if (userTopicRecords(ref).isNotEmpty) {
                    routeToSingleSubjectQuestionCount(ref);
                  } else {
                    routeToTopicSelection(
                      ref,
                      type: InterviewType.singleTopic,
                    );
                  }
                },
                child: Text(
                  tr(LocaleKeys.common_interviewTerms_startInterview),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
