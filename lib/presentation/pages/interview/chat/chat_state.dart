import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_async_adapter_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_scroll_controller.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_progress_state_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/main_input_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/recognized_text_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';

mixin class ChatState {
  ///
  /// 채팅 목록
  ///
  AsyncValue<List<BaseChatEntity>> messageHistoryAsync(WidgetRef ref) =>
      ref.watch(chatMessageHistoryProvider);

  ///
  /// 면접과 정보
  ///
  Interviewer interviewer(WidgetRef ref) =>
      ref.read(selectedChatRoomProvider).interviewer;

  ///
  /// chat page에서 사용되는 future provider들의 async 상태
  ///
  AsyncValue chatAsyncAdapterValue(WidgetRef ref) =>
      ref.watch(chatAsyncAdapterProvider);

  ///
  /// 채팅 메세지 기록
  ///
  List<BaseChatEntity> chatMessageHistory(WidgetRef ref) =>
      ref.watch(chatMessageHistoryProvider).requireValue;

  ///
  /// 채팅방
  ///
  ChatRoomEntity room(WidgetRef ref) => ref.watch(selectedChatRoomProvider);

  ///
  /// 인터뷰 진행 상태
  ///
  InterviewProgress progressState(WidgetRef ref) =>
      ref.watch(interviewProgressStateProvider);

  ///
  /// 답변이 완료되는 문답 목록
  ///
  AsyncValue<List<ChatQnaEntity>> completedQnaListAsync(WidgetRef ref) =>
      ref.watch(chatQnasProvider).whenData(
            (value) => [
              ...value.where(
                (e) => e.hasUserResponded,
              ),
            ],
          );

  ///
  /// 채팅 스크롤 컨트롤러
  ///
  ScrollController chatScrollController(WidgetRef ref) =>
      ref.watch(chatScrollControllerProvider);

  ///
  /// 처음 면접에 입장한 유저인지 여부
  ///
  bool isFirstInterview() {
    final response = userRepository.hasEnteredFirstInterview();
    return response.fold(
      onSuccess: (hasEnteredFirstInterview) {
        return !hasEnteredFirstInterview;
      },
      onFailure: (e) {
        log('CHAT STATE > $e');
        return false;
      },
    );
  }

  ///
  /// SpeechMode 상태
  ///
  bool isSpeechMode(WidgetRef ref) => ref.watch(isSpeechModeProvider);

  ///
  /// 텍스트, 스피치 모드에서 공유중인 텍스트
  ///
  String recognizedText(WidgetRef ref) => ref.watch(recognizedTextProvider);

  ///
  /// 메인 TextEditingController
  ///
  TextEditingController listenedInputController(WidgetRef ref) =>
      ref.watch(mainInputControllerProvider);

  ///
  /// 메인 TextEditingController (listened X)
  ///
  TextEditingController unListenedInputController(WidgetRef ref) =>
      ref.read(mainInputControllerProvider);
}
