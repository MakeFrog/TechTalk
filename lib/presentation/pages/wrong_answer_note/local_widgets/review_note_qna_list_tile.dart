part of '../review_note_detail_page.dart';

class _QnaListTile extends HookWidget {
  const _QnaListTile(this.wrongAnswer, {super.key});

  final WrongAnswerEntity wrongAnswer;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16) +
          const EdgeInsets.only(bottom: 92),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        if (wrongAnswer.wrongAnswerCount > 2)
          Row(
            children: [
              SvgPicture.asset(Assets.iconsRoundedBlueExclamation),
              const Gap(4),
              Text(
                '여러 번 틀린 문제',
                style: AppTextStyle.alert1.copyWith(
                  color: AppColor.of.gray4,
                ),
              )
            ],
          ),
        const Gap(4),
        Text(
          wrongAnswer.qna.question,
          style: AppTextStyle.title1,
        ),
        const Gap(8),
        _buildAnswers(),
        const Gap(46),
        Text(
          '내 답변',
          style: AppTextStyle.body1,
        ),
        const Gap(16),
        Text(
          wrongAnswer.userAnswer,
          style: AppTextStyle.body2.copyWith(
            color: AppColor.of.gray3,
          ),
        )
      ],
    );
  }

  Widget _buildAnswers() {
    final answers = wrongAnswer.qna.answers;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      itemBuilder: (context, index) {
        final answer = answers[index];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.of.gray2,
              ),
            ),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final isBlur = ref.watch(wrongAnswerBlurProvider);

              return ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: isBlur ? 4 : 0,
                  sigmaY: isBlur ? 4 : 0,
                ),
                child: Text(
                  answer,
                  style: AppTextStyle.body2,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
