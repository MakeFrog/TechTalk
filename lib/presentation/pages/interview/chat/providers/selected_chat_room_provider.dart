import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
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
  void updateInitialInfo(BaseChatEntity lastChat) {
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
  void updateProgressInfo({
    required bool isCorrect,
    required BaseChatEntity lastChatMessage,
    bool updateTotalCount = false,
  }) {
    log('결과랑이 0 : ${state.progressInfo.totalQuestionCount}');
    int totalQuestionCount = state.progressInfo.totalQuestionCount;
    if (updateTotalCount.isTrue) {
      totalQuestionCount += 1;
    }

    late ChatProgressInfoEntity updatedProgressInfo = switch (isCorrect) {
      true => state.progressInfo.copyWith(
          correctAnswerCount: state.progressInfo.correctAnswerCount + 1,
          totalQuestionCount: totalQuestionCount,
        ),
      false => state.progressInfo.copyWith(
          incorrectAnswerCount: state.progressInfo.incorrectAnswerCount + 1,
          totalQuestionCount: totalQuestionCount,
        )
    };

    final updatedRoom = state.copyWith(
      lastChatMessage: lastChatMessage.message.value,
      lastChatDate: lastChatMessage.timestamp,
      progressInfo: updatedProgressInfo,
    );

    state = updatedRoom;
    ref.read(interviewRoomsProvider.notifier).synchronizeRooms(updatedRoom);
  }
}
