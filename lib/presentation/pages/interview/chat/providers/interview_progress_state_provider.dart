import 'dart:async';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'interview_progress_state_provider.g.dart';

@Riverpod(dependencies: [SelectedChatRoom, ChatMessageHistory])
class InterviewProgressState extends _$InterviewProgressState {
  @override
  InterviewProgress build() {
    final roomProgress = ref.read(selectedChatRoomProvider).progressState;

    if (roomProgress.isCompleted) return InterviewProgress.done;

    listenMessageChanges();

    if (roomProgress.isOngoing) {
      return InterviewProgress.readyToAnswer;
    } else {
      return InterviewProgress.initial;
    }
  }

  ///
  /// 채팅 메세지 리스트를 listen하여
  /// 채팅 인터뷰 진행 상태를 조건별로 업데이트
  ///
  void listenMessageChanges() {
    ref.listen(chatMessageHistoryProvider, (prev, chatHistory) {
      if (chatHistory.value == null) return;

      final lastChat = chatHistory.value!.first;

      switch (lastChat.type) {
        case ChatType.guide:
          lastChat.message.listen(
            null,
            onDone: () {
              if (ref.read(selectedChatRoomProvider).progressState.isCompleted) {
                Future.wait([
                  _setAnalytics(),
                  _increaseCompletedCountAndAlertAppReview(),
                ]);
              }
            },
          );

        case ChatType.question:
          lastChat.message.listen(
            null,
            onDone: () {
              state = InterviewProgress.readyToAnswer;
            },
          );

        case ChatType.feedback:
          final feedbackChat = lastChat as FeedbackChatEntity;
          final isFeedbackForRootQuestion = feedbackChat.qnaId == feedbackChat.rootQnaId;
          if (isFeedbackForRootQuestion && ref.read(selectedChatRoomProvider.notifier).isLastQuestion()) {
            state = InterviewProgress.done;
            if (ref.read(isSpeechModeProvider).isTrue) {
              ref.read(isSpeechModeProvider.notifier).toggle();
            }
          }
        default:
          state = InterviewProgress.interviewerReplying;
      }
    });
  }

  ///
  /// 인터뷰가 종료되었을 때
  ///
  Future<void> _setAnalytics() async {
    unawaited(FirebaseAnalytics.instance.logEvent(
      name: 'Interview Completed',
      parameters: {
        'user_id': ref.read(userInfoProvider).requireValue?.uid,
        'user_name': ref.read(userInfoProvider).requireValue?.nickname,
        'topics': ref.read(selectedChatRoomProvider).topics.map((e) => e.text).join(', '),
        'interview_type': ref.read(selectedChatRoomProvider).type.name,
        'passOrFail': ref.read(selectedChatRoomProvider).passOrFail.name,
      },
    ));
  }

  ///
  /// 완료된 면접 개수 필드값 업데이트 및
  /// 조건에 따른 앱 리뷰 노티
  ///
  Future<void> _increaseCompletedCountAndAlertAppReview() async {
    final response = await increaseCompletedInterviewCountUseCase.call();

    unawaited(
      response.fold(
        onSuccess: (increasedCount) async {
          ref.read(userInfoProvider.notifier).increaseCompletedInterviewCount(increasedCount);
          if (ref.read(userInfoProvider).requireValue!.isReviewRequestAvailable) {
            if (increasedCount == 1 || increasedCount == 6 || increasedCount == 12 || increasedCount == 20) {
              final InAppReview inAppReview = InAppReview.instance;

              if (await inAppReview.isAvailable()) {
                unawaited(inAppReview.requestReview());
              }
            }
          }
        },
        onFailure: (e) {
          log('완료된 면접 개수 증가 로직 실패 : $e');
        },
      ),
    );
  }
}
