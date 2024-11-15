part of 'interview_result_dialog.dart';

class _InterviewInductionView extends HookConsumerWidget {
  const _InterviewInductionView({required this.type, super.key});

  final InterviewType type;

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
          /// LEADING
          InterviewType.branch(
            targetType: type,
            singleTopic: (_) => RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '같은 직군의 지원자들은\n',
                  ),
                  TextSpan(
                    text: 'Android',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '를 같이 공부하고 있어요',
                  ),
                ],
                style: AppTextStyle.body1.copyWith(
                  color: AppColor.of.gray6,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            practical: (_) => Column(
              children: <Widget>[
                Text(
                  '놓친 질문들을\n한 번 더 도전해 보세요',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.headline2,
                ),
                const Gap(8),
                Text(
                  '다른 새로운 질문들도 받을 수 있어요\n지식을 태산처럼 만들어봐요',
                  style: AppTextStyle.body3.copyWith(
                    color: AppColor.of.gray4,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            resume: (_) => Column(
              children: <Widget>[
                Text(
                  '이력서를 점검하고\n다시 도전해 보세요',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.headline2,
                ),
                const Gap(8),
                Text(
                  '완성도를 높이면 더 구체적이고\n심층적인 질문을 받을 수 있어요',
                  style: AppTextStyle.body3.copyWith(
                    color: AppColor.of.gray4,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(16),

          /// ILLUSTRATION
          Expanded(
            child: Image.asset(
              type.illusrationPath,
            ),
          ),
          if (type.isSingleTopic)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                '한 번 면접을 진행해 볼까요?',
                style: AppTextStyle.headline3,
              ),
            ),
          const Gap(
            16,
          ),
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
