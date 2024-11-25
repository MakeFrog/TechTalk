part of '../wrong_answer_detail_page.dart';

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
          const FrequentlyWrongAnswerIndicator(),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            wrongAnswer.qna.question,
            style: AppTextStyle.headline3,
          ),
        ),
        const Gap(24),
        _buildAnswers(),
        const Gap(24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 0.7,
                color: AppColor.of.red1,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                context.tr(LocaleKeys.qa_myAnswer),
                style: AppTextStyle.title1.copyWith(color: AppColor.of.red2),
              ),
              const Gap(8),
              Text(
                wrongAnswer.userAnswer,
                style: AppTextStyle.newBody.copyWith(
                  color: AppColor.of.black,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswers() {
    final answers = wrongAnswer.qna.answers;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.of.brand5,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: answers.length,
        separatorBuilder: (_, __) => const ListViewDivider(),
        itemBuilder: (context, index) {
          final answer = answers[index];

          return Consumer(
            builder: (context, ref, child) {
              final isBlur = ref.watch(wrongAnswerBlurProvider);

              return AnimatedOpacity(
                opacity: isBlur ? 0.2 : 1,
                duration: const Duration(milliseconds: 60),
                child: ImageFiltered(
                  enabled: isBlur,
                  imageFilter: ImageFilter.blur(
                    sigmaX: 8,
                    sigmaY: 8,
                  ),
                  child: Text(
                    answer,
                    style: AppTextStyle.body2.copyWith(
                      color: isBlur ? AppColor.of.gray1 : AppColor.of.black,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
