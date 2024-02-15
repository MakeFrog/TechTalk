part of '../wrong_answer_note_page.dart';

class _FloatingBtn extends ConsumerWidget
    with WrongAnswerNoteState, WrongAnswerNoteEvent {
  const _FloatingBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HookBuilder(
      builder: (context) {
        final isShown = useState(false);

        scrollController(ref).addListener(() {
          final scrollPosition = scrollController(ref).offset;

          if (WrongAnswerNoteScrollController.animatedOffset > scrollPosition &&
              isShown.value) {
            isShown.value = false;
            return;
          }

          if (WrongAnswerNoteScrollController.animatedOffset <=
                  scrollPosition &&
              !isShown.value) {
            isShown.value = true;
            return;
          }
        });
        return AnimatedOpacity(
          opacity: isShown.value ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: MaterialButton(
            onPressed: () {
              scrollController(ref).animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            height: 56,
            minWidth: 56,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            color: AppColor.of.brand2,
            child: SvgPicture.asset(
              Assets.iconsArrowUp,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
