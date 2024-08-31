import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_scroll_controller.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

mixin class ChatEvent {
  /// 채팅 입력창이 전송 되었을 때
  ///
  /// - 유저 채팅 응답 추가
  /// - 유저 채팅 응답
  /// - 입력된 채팅 state 초기화
  /// - 스크롤 포지션 맨 아래로 변경
  ///
  Future<void> onChatFieldSubmitted(
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) async {
    unawaited(
      ref.read(chatScrollControllerProvider).animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
    );

    final message = textEditingController.text;
    if (message.isEmpty) {
      unawaited(HapticFeedback.vibrate());
      return SnackBarService.showSnackBar(
          ref.context.tr(LocaleKeys.interview_provideAnswer));
    }
    textEditingController.clear();

    await ref
        .read(chatMessageHistoryProvider.notifier)
        .proceedInterviewStep(message);
  }

  ///
  /// 채팅 전송이 불가능할 상태일 때 전송 버튼이 클릭 되었을 때
  ///
  void onChatFieldSubmittedOnWaitingState(InterviewProgress progressState) {
    unawaited(HapticFeedback.vibrate());
    late String message;

    final context = rootNavigatorKey.currentContext!;
    if (progressState.isDone) {
      message = context.tr(LocaleKeys.interview_interviewEnded);
    }

    if (progressState.isError) {
      message = context.tr(LocaleKeys.interview_errorHasDetected);
    }

    if (progressState.isInterviewerReplying) {
      message = context.tr(LocaleKeys.interview_waitForReply);
    }

    return SnackBarService.showSnackBar(message);
  }

  ///
  /// 앱바 뒤로 가기 버튼이 클릭 되었을 때
  ///
  void onAppbarBackBtnTapped(WidgetRef ref) {
    final room = ref.read(selectedChatRoomProvider);

    if (room.progressState.isOngoing) {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          title: rootNavigatorKey.currentContext!
              .tr(LocaleKeys.interview_notification),
          subTitle: rootNavigatorKey.currentContext!
              .tr(LocaleKeys.interview_confirmEndInterview),
          description: rootNavigatorKey.currentContext!
              .tr(LocaleKeys.interview_continueLater),
          showContentImg: false,
          leftBtnContent:
              rootNavigatorKey.currentContext!.tr(LocaleKeys.common_cancel),
          rightBtnContent:
              rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
          onRightBtnClicked: () {
            ref.context.pop();
            ref.context.pop();
          },
          onLeftBtnClicked: () {
            ref.context.pop();
          },
        ),
      );
    } else {
      ref.context.pop();
    }
  }

  ///
  /// 리포트 버튼이 클릭 되었을 때
  ///
  Future<void> onReportBtnTapped(
    WidgetRef ref, {
    required int index,
  }) async {
    final chatMessages = ref.read(chatMessageHistoryProvider).requireValue;

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: tr(LocaleKeys.undefined_report),
        subTitle: tr(LocaleKeys.undefined_weirdResponse),
        description: tr(LocaleKeys.undefined_helpImproveAccuracy),
        leftBtnContent: tr(LocaleKeys.common_cancel),
        rightBtnContent: tr(LocaleKeys.common_confirm),
        showContentImg: false,
        onRightBtnClicked: () async {
          await reportChatUseCase(
            chatMessages[index] as FeedbackChatEntity,
            chatMessages[index + 1] as AnswerChatEntity,
          ).then((value) {
            value.fold(
              onSuccess: (value) {
                ref.context.pop();
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  SnackBar(
                    content: Text(tr(LocaleKeys.undefined_thankYouForFeedback)),
                  ),
                );
              },
              onFailure: (e) {
                ref.context.pop();
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  SnackBar(
                    content: Text(tr(LocaleKeys.undefined_thankYouForFeedback)),
                  ),
                );
              },
            );
          });
        },
        onLeftBtnClicked: () {
          ref.context.pop();
        },
      ),
    );
  }

  ///
  /// 면접 처음 입장한 유저의 경우
  /// 면접 처음 입장했다는 local Storage 값의 상태를 업데이트
  ///
  void updateFirstEnteredStateToTrue() {
    final response = userRepository.hasEnteredFirstInterview();
    response.fold(
      onSuccess: (hasEnteredFirstInterview) async {
        if (hasEnteredFirstInterview) return;
        await userRepository.changeFirstEnteredFieldToTrue();
        print('면접 최초 실행 여부 값 업데이트');
      },
      onFailure: (e) {
        log('CARD EVENT > $e');
        return Exception('로컬 스토리지 업데이트 실패');
      },
    );
  }

  ///
  /// 음성 인식 활성화
  /// '마이크' 버튼이 클릭 되었을 때
  ///
  void onMicBtnTapped() {}
}
