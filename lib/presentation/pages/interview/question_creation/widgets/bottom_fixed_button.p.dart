part of '../question_creation_page.dart';

class _BottomFixedButton extends ConsumerWidget
    with QuestionCreationState, QuestionCreationEvent {
  const _BottomFixedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 220,
      ),
      child: hasQuestionCreated(ref)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BounceTapper(
                onTap: () {
                  onStartInterViewBtnTapped(ref);
                },
                child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {},
                        child: Text(tr(LocaleKeys
                            .interview_questionCreation_startInterview)))),
              ),
            )
          : const EmptyBox(),
    );
  }
}
