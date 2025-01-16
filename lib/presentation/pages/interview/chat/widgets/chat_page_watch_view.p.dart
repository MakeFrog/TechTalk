part of '../chat_page.dart';

class _WatchView extends ConsumerWidget {
  const _WatchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedChatRoomProvider);
    return const EmptyBox();
  }
}
