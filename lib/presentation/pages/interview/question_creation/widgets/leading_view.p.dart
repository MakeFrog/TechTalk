part of '../question_creation_page.dart';

class _LeadingView extends ConsumerWidget with QuestionCreationState {
  const _LeadingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
      future: nicknameFuture(ref),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        final nickname = snapshot.data ?? tr(LocaleKeys.common_emptyName);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (context) {
              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 340,
                ),
                child: hasQuestionCreated(ref)
                    ? Text(
                        tr(LocaleKeys.interview_questionCreation_ready_title,
                            namedArgs: {'nickname': nickname}),
                        style: AppTextStyle.headline1,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(
                                LocaleKeys
                                    .interview_questionCreation_loading_title,
                                namedArgs: {'nickname': nickname}),
                            style: AppTextStyle.headline1,
                          ),
                          const Gap(12),
                          Text(
                            tr(LocaleKeys
                                .interview_questionCreation_loading_description),
                            style: AppTextStyle.body1.copyWith(
                              color: AppColor.of.gray4,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
