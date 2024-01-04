import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
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
    textEditingController.clear();
    if (message.isEmpty) {
      return ToastService.show(
        NormalToast(message: '답변을 입력해 주세요'),
      );
    }
    final room = ref.read(selectedChatRoomProvider);

    await ref
        .read(chatMessageHistoryProvider(room).notifier)
        .addUserChatResponse(message);
  }

  /// 앱바 뒤로 가기 버튼이 클릭 되었을 때
  void onAppbarBackBtnTapped(BuildContext context) {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '알림',
        subTitle: '정말 면접을 종료하시겠어요?',
        description: '나중에 면접을 이어서 진행할 수 있습니다',
        leftBtnContent: '취소',
        rightBtnContent: '확인',
        onRightBtnClicked: () {
          context
            ..pop()
            ..pop();
        },
        onLeftBtnClicked: () {
          context.pop();
        },
      ),
    );
  }
}
