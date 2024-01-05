import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'chat_qnas_provider.g.dart';

@riverpod
class ChatQnAs extends _$ChatQnAs {
  Future<List<ChatQnaEntity>> _getRandomQnas() async {
    final qnas = await getTopicQnasUseCase(room.topics.first.id).then(
      (value) => value.getOrThrow(),
    )
      ..shuffle();

    return qnas
        .sublist(0, room.progressInfo.totalQuestionCount)
        .map(
          (e) => ChatQnaEntity(
            id: e.id,
            question: e,
          ),
        )
        .toList();
  }

  @override
  FutureOr<List<ChatQnaEntity>> build(ChatRoomEntity room) async {
    final qnas = await getChatQnasUseCase(room);
    return qnas.fold(
      onSuccess: (value) async {
        if (value.isEmpty) {
          return _getRandomQnas();
        } else {
          return value;
        }
      },
      onFailure: (e) async {
        return _getRandomQnas();
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

  QuestionChatMessageEntity createQuestionChat({
    bool isStream = true,
  }) {
    final qna = state.requireValue.firstWhere((qna) => !qna.hasUserResponded);

    if (isStream) {
      return QuestionChatMessageEntity(
        qnaId: qna.id,
        message: qna.question.question.convertToStreamText,
      );
    } else {
      return QuestionChatMessageEntity.createStatic(
        qnaId: qna.id,
        message: qna.question.question,
        timestamp: DateTime.now(),
      );
    }
  }
}
