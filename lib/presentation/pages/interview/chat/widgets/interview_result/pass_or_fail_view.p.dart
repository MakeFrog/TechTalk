part of 'interview_result_dialog.dart';

class _PassOrFailView extends HookConsumerWidget with ChatState, ChatEvent {
  const _PassOrFailView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        28,
        16,
        16,
      ),
      decoration: BoxDecoration(
        color: AppColor.of.white,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: <Widget>[
          Text(
            room(ref).interviewResult.isPassed ? '합격했어요!' : '불합격했어요',
            style: AppTextStyle.headline1,
          ),
          const Spacer(),
          const Gap(4),
          Text(
            room(ref).interviewResult.isPassed
                ? '앞으로도 꾸준히 해서 취뽀 성공!'
                : '꾸준히 하면 분명 달라질 거예요',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray5,
            ),
          ),
          const Gap(16),
          SvgPicture.asset(room(ref).interviewResult.illustration),
          const Gap(8),
          InterviewCountResultIndicator(
            result: room(ref).interviewResult,
            correctAnswerCount: room(ref).progressInfo.correctAnswerCount,
            totalCount: room(ref).progressInfo.totalQuestionCount,
          ),
          const Gap(24),
          const Spacer(),
          SizedBox(
            height: 48,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    child: FilledButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: AppColor.of.brand3,
                        backgroundColor: AppColor.of.blue1,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                      ),
                      child: Text(
                        '취소',
                        style: AppTextStyle.title1,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                    ),
                    onPressed: () {
                      changePageViewIndex(ref, index: 1);
                    },
                    child: const Text(
                      '다음',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
