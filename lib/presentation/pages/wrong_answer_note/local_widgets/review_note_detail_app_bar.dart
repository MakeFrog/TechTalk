part of '../wrong_answer_detail_page.dart';

class _AppBar extends ConsumerWidget
    with WrongAnswerNoteState, WrongAnswerNoteEvent
    implements PreferredSizeWidget {
  const _AppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onHideAnswerSwitchTapped(ref),
      child: BackButtonAppBar(
        title: selectedTopic(ref)!.text,
        actions: [
          Text(
            tr(LocaleKeys.learning_hideAnswers),
            style: AppTextStyle.alert1.copyWith(
              color: AppColor.of.gray3,
            ),
          ),
          const Gap(8),
          Consumer(
            builder: (context, ref, child) {
              final isBlurAnswer = ref.watch(wrongAnswerBlurProvider);

              return FlatSwitch(
                value: isBlurAnswer,
                onTap: (_) => onHideAnswerSwitchTapped(ref),
              );
            },
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
