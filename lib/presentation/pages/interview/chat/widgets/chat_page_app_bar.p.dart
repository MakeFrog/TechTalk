part of '../chat_page.dart';

class _AppBar extends HookConsumerWidget
    with ChatState, ChatEvent
    implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? appBarTitle = useMemoized(() {
      room(ref).type.typedBranch(
        common: (_) {
          final firstTopic =
              ref.watch(selectedChatRoomProvider).topics.first.text;
          final otherTopicCount = room(ref).topics.length - 1;
          return '$firstTopic${otherTopicCount > 0 ? ' ${tr(LocaleKeys.undefined_and)} $otherTopicCount' : ''}';
        },
        resume: (_) {
          return '이력서 면접';
        },
        youtube: (_) {
          return '';
        },
      );
    });

    return BackButtonAppBar(
      title: appBarTitle ?? '',
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
                tr(LocaleKeys.interview_followUpQuestion),
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
                    onTap: (_) async {
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
