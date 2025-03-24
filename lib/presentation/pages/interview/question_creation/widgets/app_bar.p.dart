part of '../question_creation_page.dart';

class _AppBar extends ConsumerWidget
    with QuestionCreationState, QuestionCreationEvent
    implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      onBackBtnTapped: () {
        onBackBtnTapped(ref);
      },
      actions: [
        Consumer(
          builder: (context, ref, _) {
            return AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 500,
              ),
              child: hasQuestionCreated(ref)
                  ? SeeAllQuestionButton(
                      padding: const EdgeInsets.only(right: 16),
                      onTap: () {},
                    )
                  : const EmptyBox(),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
