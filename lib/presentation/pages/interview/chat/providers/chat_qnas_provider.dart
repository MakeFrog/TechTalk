import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'chat_qnas_provider.g.dart';

@riverpod
class ChatQnAs extends _$ChatQnAs {
  @override
  FutureOr<List<ChatQnaEntity>> build(ChatRoomEntity room) async {
    final qnas = await getChatQnasUseCase(room);
    return qnas.fold(
      onSuccess: (value) async {
        if (value.isEmpty) {
          print(value);
          final qnas = await getTopicQnasUseCase(room.topic.id).then(
            (value) => value.getOrThrow(),
          )
            ..shuffle();

          print(qnas);
          return qnas
              .sublist(0, room.progressInfo.totalQuestionCount)
              .map(
                (e) => ChatQnaEntity(
                  question: e,
                ),
              )
              .toList();
        } else {
          return value;
        }
      },
      onFailure: (e) async {
        final qnas = await getTopicQnasUseCase(room.topic.id).then(
          (value) => value.getOrThrow(),
        )
          ..shuffle();

        return qnas
            .sublist(0, room.progressInfo.totalQuestionCount)
            .map(
              (e) => ChatQnaEntity(
                question: e,
              ),
            )
            .toList();
      },
    );
  }

  Future<void> updateState(AnswerChatMessageEntity message) async {
    final qnas = state.requireValue;
    final targetQnaIndex = qnas.indexWhere(
      (element) => element.id == message.qnaId,
    );
    final resolvedQna = qnas[targetQnaIndex].copyWith(
      answer: message,
    );

    await update((previous) {
      return [...previous]..[targetQnaIndex] = resolvedQna;
    });
  }
}
