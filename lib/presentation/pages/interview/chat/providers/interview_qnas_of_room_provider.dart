import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'interview_qnas_of_room_provider.g.dart';

@riverpod
class InterviewQnAsOfRoom extends _$InterviewQnAsOfRoom {
  @override
  FutureOr<List<ChatQnaEntity>> build(ChatRoomEntity room) async {
    if (room.isTempRoom) {
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
    } else {
      final qnas = await getChatQnasUseCase(
        room.id,
      );

      return qnas.getOrThrow();
    }
  }

  ChatQnaEntity? getFirstNotResponseQna() {
    try {
      return state.requireValue.firstWhere((qna) => !qna.hasUserResponded);
    } catch (e) {
      return null;
    }
  }

  void updateQnA(AnswerChatMessageEntity message) {
    final qnas = state.requireValue;
    final targetQnaIndex = qnas.indexWhere(
      (element) => element.id == message.qnaId,
    );
    final resolvedQna = qnas[targetQnaIndex].copyWith(
      answer: UserInterviewResponse(
        message.message.value,
        state: message.answerState,
      ),
    );

    update((previous) {
      return [...previous]..[targetQnaIndex] = resolvedQna;
    });
  }
}
