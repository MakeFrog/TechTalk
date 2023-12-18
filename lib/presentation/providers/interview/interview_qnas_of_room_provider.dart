import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'interview_qnas_of_room_provider.g.dart';

@riverpod
class InterviewQnAsOfRoom extends _$InterviewQnAsOfRoom {
  @override
  FutureOr<List<InterviewQnAEntity>> build(ChatRoomEntity room) async {
    final qnas = await getChatQnAsUseCase(
      room.chatRoomId,
    );

    return qnas.getOrThrow();
  }

  void updateQnA(SentMessageEntity message) {
    final qnas = state.requireValue;
    final targetQnaIndex = qnas.indexWhere(
      (element) => element.id == message.qnaId,
    );
    final resolvedQna = qnas[targetQnaIndex].copyWith(
      response: UserInterviewResponse(
        message.message.value,
        state: message.answerState,
      ),
    );

    update((previous) {
      return [...previous]..[targetQnaIndex] = resolvedQna;
    });
  }
}
