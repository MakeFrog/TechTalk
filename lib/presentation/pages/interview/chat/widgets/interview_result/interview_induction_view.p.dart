part of 'interview_result_dialog.dart';

class _InterviewInductionView extends HookConsumerWidget
    with ChatState, ChatEvent {
  const _InterviewInductionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final relatedTopic = useMemoized(() => randomRelatedTopicName(ref));

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
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          /// LEADING
          room(ref).type.branch(
                singleTopic: (_) => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: tr(
                            LocaleKeys.interview_suggestSimilarTopicsLeading),
                      ),
                      TextSpan(
                        text: relatedTopic?.text ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: tr(LocaleKeys.interview_suggestSimilarTopicsEnd),
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
                      tr(LocaleKeys.interview_tryRecap),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.headline2,
                    ),
                    const Gap(8),
                    Text(
                      tr(LocaleKeys.interview_retryInterview),
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
                youtube: (InterviewType type) {
                  return Text('작업 필요');
                },
              ),
          const Gap(16),

          /// ILLUSTRATION
          Expanded(
            child: Image.asset(
              room(ref).type.illusrationPath,
            ),
          ),
          if (room(ref).type.isSingleTopic)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                tr(LocaleKeys.interview_letsTryInterviewAgain),
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
                        routeToHome(context);
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: AppColor.of.gray3,
                        backgroundColor: AppColor.of.gray1,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                      ),
                      child: Text(
                        tr(LocaleKeys.interview_goToHome),
                        style: AppTextStyle.title1,
                        textAlign: TextAlign.center,
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
                      room(ref).type.branch(
                            singleTopic: (_) {
                              startRelatedNewTopicInterview(
                                ref,
                                targetTopic: relatedTopic!,
                              );
                            },
                            practical: (_) {
                              retryThisInterview(ref);
                            },
                            resume: (_) {
                              /// TODO : XIMYA
                              /// 테스트 필요
                              retryThisInterview(ref);
                            },
                            youtube: (InterviewType type) {},
                          );
                    },
                    child: Text(
                      room(ref).type.branch(
                            singleTopic: (_) =>
                                tr(LocaleKeys.home_takeInterview),
                            practical: (_) => tr(LocaleKeys.interview_tryAgain),
                            resume: (_) => tr(LocaleKeys.interview_tryAgain),
                            youtube: (InterviewType type) {
                              return '작업 필요';
                            },
                          ),
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
