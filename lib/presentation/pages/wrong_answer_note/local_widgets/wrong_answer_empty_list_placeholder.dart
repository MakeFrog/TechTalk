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
          if (userTopicRecords(ref).isNotEmpty)
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
                    routeToSingleSubjectQuestionCount(ref);
                  },
                  child: Text(
                    tr(LocaleKeys.common_interviewTerms_goToInterview),
                  ),
                ),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BounceTapper(
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
                      routeToTopicSelection(
                        ref,
                        type: InterviewType.singleTopic,
                      );
                    },
                    child: Text(
                      tr(LocaleKeys.common_interviewTerms_topicInterview),
                    ),
                  ),
                ),
                const Gap(8),
                BounceTapper(
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
                      routeToTopicSelection(
                        ref,
                        type: InterviewType.practical,
                      );
                    },
                    child: Text(
                      tr(LocaleKeys.common_interviewTerms_practicalInterview),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
