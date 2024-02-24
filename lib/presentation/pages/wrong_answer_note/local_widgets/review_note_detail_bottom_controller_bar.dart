part of '../wrong_answer_detail_page.dart';

class _BottomControllerBar extends ConsumerWidget
    with WrongAnswerNoteState, WrongAnswerNoteEvent {
  const _BottomControllerBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      height: 70,
      width: double.infinity,
      child: HookBuilder(
        builder: (context) {
          final currentPage = useListenableSelector(
            pageController(ref),
            () => pageController(ref).page?.round() ?? WrongAnswerRoute.arg,
          );

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnderLabelIconButton(
                isActive: currentPage != 0,
                label: '이전 문항',
                icon: Assets.iconsArrowLeft,
                onTap: () => jumpToPreviousPage(ref),
              ),
              const Spacer(),
              UnderLabelIconButton(
                isActive: currentPage + 1 !=
                    wrongAnswersAsync(ref).requireValue.length,
                label: '다음 문항',
                icon: Assets.iconsArrowRight,
                onTap: () => jumpToNextPage(ref),
              ),
            ],
          );
        },
      ),
    );
  }
}
