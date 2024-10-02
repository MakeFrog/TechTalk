part of '../chat_page.dart';

class _AppBar extends ConsumerWidget
    with ChatState, ChatEvent
    implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstTopic = ref.watch(selectedChatRoomProvider).topics.first.text;
    final otherTopicCount =
        ref.watch(selectedChatRoomProvider).topics.length - 1;

    return BackButtonAppBar(
      title:
          '$firstTopic${otherTopicCount > 0 ? ' ${tr(LocaleKeys.undefined_and)} $otherTopicCount' : ''}',
      onBackBtnTapped: () {
        onAppbarBackBtnTapped(ref);
      },
      actions: [
        GestureDetector(
          onTap: () {
            toggleFollowUpQuestionActiveState(ref);
          },
          child: Row(
            children: [
              Text(
                '꼬리 질문',
                style: AppTextStyle.alert1,
              ),
              const Gap(6),
              Consumer(
                builder: (context, ref, _) {
                  final isActive = isFollowUpProcessActive(ref);
                  return FlatSwitch(
                    height: 24,
                    value: isActive,
                    bgColor: AppColor.of.purple2,
                    onTap: (_) {
                      toggleFollowUpQuestionActiveState(ref);
                    },
                  );
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(BackButtonAppBar.appbarHeight);
}
