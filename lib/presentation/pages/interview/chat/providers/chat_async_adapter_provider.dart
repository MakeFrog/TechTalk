import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_progress_state_provider.dart';

part 'chat_async_adapter_provider.g.dart';

///
/// [chatQnasProvider][chatMessageHistoryProvider]
/// 위 provider의 async build 여부를 확인하여 [AsyncValue] 인스턴스를 리턴
/// [ChatPage] 위젯에서 사용됨.
///

@Riverpod(dependencies: [ChatQnas, ChatMessageHistory])
class ChatAsyncAdapter extends _$ChatAsyncAdapter {
  @override
  AsyncValue build() {
    return ref.watch(chatQnasProvider).when(
          data: (_) {
            return ref.watch(chatMessageHistoryProvider).when(
                  data: (_) {
                    ref
                        .read(interviewProgressStateProvider.notifier)
                        .listenMessageChanges();
                    return const AsyncData(null);
                  },
                  error: AsyncError.new,
                  loading: AsyncLoading.new,
                );
          },
          error: AsyncError.new,
          loading: AsyncLoading.new,
        );
  }
}
