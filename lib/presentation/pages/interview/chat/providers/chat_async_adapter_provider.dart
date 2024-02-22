import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';

part 'chat_async_adapter_provider.g.dart';

///
/// [chatQnasProvider][chatMessageHistoryProvider]
/// 위 provider의 async build 여부를 확인하여 [AsyncValue] 인스턴스를 리턴
/// [ChatPage] 위젯에서 사용됨.
///

@riverpod
class ChatAsyncAdapter extends _$ChatAsyncAdapter {
  @override
  AsyncValue build() {
    ref.listen(chatQnasProvider, (previous, next) {
      if (next.hasValue) {
        ref.listen(chatMessageHistoryProvider, (previous, next) {
          if (next.hasValue) {
            state = const AsyncData(null);
          }
        });
      }
    });

    return const AsyncLoading();
  }
}
