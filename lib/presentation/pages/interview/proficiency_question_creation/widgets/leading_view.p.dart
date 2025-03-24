part of '../proficiency_question_creation_page.dart';

class _LeadingView extends ConsumerWidget
    with ProficiencyQuestionCreationState {
  const _LeadingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
      future: nicknameFuture(ref),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        final nickname = snapshot.data ?? '익명';
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
                        '$nickname님을 위한\n면접 질문이 준비 됐어요!',
                        style: AppTextStyle.headline1,
                      )
                    : Text(
                        '잠시만요 $nickname님,\n질문을 생성하고 있어요',
                        style: AppTextStyle.headline1,
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
