part of 'interview_result_dialog.dart';

class _PassOrFailView extends StatelessWidget {
  const _PassOrFailView({
    super.key,
    required this.result,
    required this.totalCount,
    required this.correctAnswerCount,
  });

  final InterviewResult result;
  final int totalCount;
  final int correctAnswerCount;

  @override
  Widget build(BuildContext context) {
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
            '합격했어요!',
            style: AppTextStyle.headline1,
          ),
          const Spacer(),
          const Gap(4),
          Text(
            '앞으로도 꾸준히 해서 취뽀 성공!',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray5,
            ),
          ),
          const Gap(16),
          SvgPicture.asset(Assets.iconsPassResult),
          const Gap(8),
          const InterviewCountResultIndicator(
            result: InterviewResult.pass,
            correctAnswerCount: 4,
            totalCount: 10,
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
                    onPressed: () {},
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
