part of '../wrong_answer_note_page.dart';

class _EmptyListPlaceholder extends ConsumerWidget
    with WrongAnswerNoteState, WrongAnswerNoteEvent {
  const _EmptyListPlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ExceptionIndicator(
            title: tr(LocaleKeys.mistakeNote_noMistakeRecords),
            subTitle: tr(
              LocaleKeys.mistakeNote_letsHaveInterview,
              namedArgs: {
                'tech': userTopicRecords(ref).isNotEmpty
                    ? selectedTopic(ref)!.text
                    : '',
              },
            ),

            //  '지금 ${userTopicRecords(ref).isNotEmpty ? '${selectedTopic(ref)!.text} ' : ''}면접을 진행해보세요!',
          ),
          const Gap(22),
          Builder(
            builder: (context) {
              if (userTopicRecords(ref).isNotEmpty) {
                return Center(
                  child: BounceTapper(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 34,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
                        routeToSingleSubjectQuestionCount(ref);
                      },
                      child: Text(
                        tr(LocaleKeys.common_interviewTerms_startInterview),
                      ),
                    ),
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceTapper(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          routeToTopicSelection(
                            ref,
                            type: InterviewType.singleTopic,
                          );
                        },
                        child: Text(
                          context.tr(LocaleKeys.common_topicInterviewFormat),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Gap(8),
                    BounceTapper(
                      child: OutlinedButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          routeToTopicSelection(
                            ref,
                            type: InterviewType.practical,
                          );
                        },
                        child: Text(
                          context.tr(
                            LocaleKeys.common_practicalInterviewFormat,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
