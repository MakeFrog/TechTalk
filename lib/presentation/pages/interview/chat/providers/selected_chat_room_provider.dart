import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/entities/chat_progress_info_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/interview_rooms_provider.dart';

part 'selected_chat_room_provider.g.dart';

@riverpod
class SelectedChatRoom extends _$SelectedChatRoom {
  @override
  ChatRoomEntity build() {
    return ChatPageRoute.arg;
  }

  ///
  /// 초기 채팅방 정보 업데이트
  ///
  void updateInitialInfo(ChatMessageEntity lastChat) {
    final updatedRoom = state.copyWith(
      lastChatDate: lastChat.timestamp,
      lastChatMessage: lastChat.message.value,
      chatProgressState: ChatRoomProgress.ongoing,
    );

    state = updatedRoom;
    ref.read(interviewRoomsProvider.notifier).synchronizeRooms(updatedRoom);
  }

  ///
  /// 채팅 진행상태 정보 업데이트
  ///
  void updateProgressInfo(
      {required bool isCorrect, required ChatMessageEntity lastChatMessage}) {
    late ChatProgressInfoEntity updatedProgressInfo = switch (isCorrect) {
      true => state.progressInfo.copyWith(
          correctAnswerCount: state.progressInfo.correctAnswerCount + 1),
      false => state.progressInfo.copyWith(
          incorrectAnswerCount: state.progressInfo.incorrectAnswerCount + 1)
    };

    final updatedRoom = state.copyWith(
      lastChatMessage: lastChatMessage.message.value,
      lastChatDate: lastChatMessage.timestamp,
      progressInfo: updatedProgressInfo,
    );

    state = updatedRoom;
    ref.read(interviewRoomsProvider.notifier).synchronizeRooms(updatedRoom);
  }

  ///
  /// 마지막 질문 여부
  ///
  bool isLastQuestion() {
    return state.progressInfo.completedQuestionCount + 1 ==
        state.progressInfo.totalQuestionCount;
  }
}
