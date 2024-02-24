part of '../learning_detail_page.dart';

class _AppBar extends ConsumerWidget
    with LearningDetailEvent
    implements PreferredSizeWidget {
  const _AppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      title: ref.watch(selectedStudyTopicProvider).text,
      actions: [
        Text(
          '답안 가리기',
          style: AppTextStyle.alert1.copyWith(
            color: AppColor.of.gray3,
          ),
        ),
        const Gap(8),
        Consumer(
          builder: (context, ref, child) => FlatSwitch(
            value: ref.watch(studyAnswerBlurProvider),
            onTap: (_) => onToggleAnswerBlur(ref),
          ),
        ),
        const Gap(16),
      ],
    );
  }
}
