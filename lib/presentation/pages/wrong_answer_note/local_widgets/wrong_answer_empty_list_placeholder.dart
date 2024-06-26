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
            title: '아직 오답 문제가 없어요.',
            subTitle:
                '지금 ${userTopicRecords(ref).isNotEmpty ? '${selectedTopic(ref)!.text} ' : ''}면접을 진행해보세요!',
          ),
          const Gap(22),
          Builder(
            builder: (context) {
              if (userTopicRecords(ref).isNotEmpty) {
                return Center(
                  child: AnimatedScaleTap(
                    borderRadius: BorderRadius.circular(16),
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
                      child: const Text('면접보기'),
                    ),
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScaleTap(
                      borderRadius: BorderRadius.circular(16),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          routeToTopicSelection(ref,
                              type: InterviewType.singleTopic);
                        },
                        child: const Text('주제별 면접'),
                      ),
                    ),
                    const Gap(8),
                    AnimatedScaleTap(
                      borderRadius: BorderRadius.circular(16),
                      child: OutlinedButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          routeToTopicSelection(ref,
                              type: InterviewType.practical);
                        },
                        child: const Text('실전형 면접'),
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
