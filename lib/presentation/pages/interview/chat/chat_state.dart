import 'dart:developer';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/get_one_line_interview_feedback_use_case.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_async_adapter_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_scroll_controller.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_progress_state_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_result_page_view_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/is_follow_up_process_active_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/main_input_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/one_line_feedback_provider.dart';
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
  InterviewProgress interviewProgressState(WidgetRef ref) =>
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

  ///
  /// focusNode
  ///
  FocusNode focusNode(WidgetRef ref) =>
      ref.read(mainInputControllerProvider.notifier).focusNode;

  ///
  /// 꼬리 질문 활성화 여부
  ///
  bool isFollowUpProcessActive(WidgetRef ref) =>
      ref.watch(isFollowUpProcessActiveProvider);

  ///
  /// 페이지뷰 컨트롤러
  ///
  PageController chatResultPageViewController(WidgetRef ref) =>
      ref.watch(interviewResultPageViewControllerProvider);

  ///
  /// 한줄평 피드백
  ///
  BehaviorSubject<String> oneLineStreamFeedback(WidgetRef ref) =>
      ref.watch(oneLineFeedbackProvider);

  ///
  /// 현재 선택된 주제와 관련된 주제 (여러개 중 하나를 랜덤으로 추출)
  ///
  TopicEntity randomRelatedTopicName(WidgetRef ref) {
    final relatedTopics =
        ref.read(selectedChatRoomProvider).topics.first.relatedSkillIds;

    final math.Random random = math.Random();
    final int randomIndex = random.nextInt(relatedTopics.length);

    return StoredTopics.getById(relatedTopics[randomIndex]);
  }
}
