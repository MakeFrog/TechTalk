import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
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
    final message = textEditingController.text;
    if (message.isEmpty) {
      return SnackBarService.showSnackBar('답변을 입력해 주세요');
    }
    textEditingController.clear();

    await ref
        .read(chatMessageHistoryProvider.notifier)
        .proceedInterviewStep(message);
  }

  void onChatFieldSubmittedOnWaitingState() {
    SnackBarService.showSnackBar('면접관의 응답이 마무리된 이후 답변을 전송해주세요.');
  }
  /// 앱바 뒤로 가기 버튼이 클릭 되었을 때
  void onAppbarBackBtnTapped(WidgetRef ref) {
    final room = ref.read(selectedChatRoomProvider);

    if (room.progressState.isOngoing) {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          title: '알림',
          subTitle: '정말 면접을 종료하시겠어요?',
          description: '나중에 면접을 이어서 진행할 수 있습니다',
          leftBtnContent: '취소',
          rightBtnContent: '확인',
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

  Future<void> onReportBtnTapped(
    WidgetRef ref, {
    required int index,
  }) async {
    final chatMessages = ref.read(chatMessageHistoryProvider).requireValue;

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '신고',
        subTitle: '면접관의 답변이 이상하신가요?',
        description: '면접관의 답변을 신고해 정확도를 향상시키는데 도움을 주시면 감사하겠습니다.',
        leftBtnContent: '취소',
        rightBtnContent: '확인',
        onRightBtnClicked: () async {
          await reportChatUseCase(
            chatMessages[index] as FeedbackChatMessageEntity,
            chatMessages[index + 1] as AnswerChatMessageEntity,
          ).then((value) {
            value.fold(
              onSuccess: (value) {
                ref.context.pop();
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  const SnackBar(
                    content: Text('신고해주셔서 감사합니다.'),
                  ),
                );
              },
              onFailure: (e) {
                ref.context.pop();
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  const SnackBar(
                    content: Text('오류가 발생했습니다. 다시 시도해주세요.'),
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
}
