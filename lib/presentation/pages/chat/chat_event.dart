import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_input_provider.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_list_provider.dart';
import 'package:techtalk/presentation/pages/chat/providers/chat_scroll_controller_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

abstract class _ChatEvent {
  /// 채팅 입력창이 전송 되었을 때
  Future<void> onChatFieldSubmitted(WidgetRef ref, {required String message});

  /// 앱바 뒤로 가기 버튼이 클릭 되었을 때
  void onAppbarBackBtnTapped();

  /// 모든 provider 제거
  void disposeProviders(WidgetRef ref);
}

mixin class ChatEvent implements _ChatEvent {
  ///
  /// - 유저 채팅 응답 추가
  /// - 유저 채팅 응답
  /// - 입력된 채팅 state 초기화
  /// - 스크롤 포지션 맨 아래로 변경
  ///
  @override
  Future<void> onChatFieldSubmitted(WidgetRef ref,
      {required String message}) async {
    ref.read(chatScrollControllerProvider.notifier).setScrollPositionToBottom();

    if (message.isEmpty) {
      return ToastService.show(
        NormalToast(message: '답변을 입력해 주세요'),
      );
    }

    await ref
        .read(chatListProvider.notifier)
        .addUserChatResponse(message: message);
    await ref
        .read(chatListProvider.notifier)
        .respondToUserAnswer(userAnswer: message);

    ref.read(chatInputProvider.notifier).reset();
  }

  @override
  void onAppbarBackBtnTapped() {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '알림',
        subTitle: '정말 면접을 종료하시겠어요?',
        description: '나중에 면접을 이어서 진행할 수 있습니다',
        leftBtnContent: '취소',
        rightBtnContent: '확인',
        onRightBtnClicked: () {
          rootNavigatorKey.currentContext!.pop();
          rootNavigatorKey.currentContext!.pop();
        },
        onLeftBtnClicked: () {
          rootNavigatorKey.currentContext!.pop();
        },
      ),
    );
  }

  @override
  void disposeProviders(WidgetRef ref) {
    // ref.invalidate(chatFocusNodeProvider);

    // ref.disposeProviders([
    //   chatFocusNodeProvider,
    //   chatInputProvider,
    //   chatListProvider,
    //   chatScrollControllerProvider,
    //   completedQnAListProvider,
    //   totalQnaListProvider,
    // ]);
  }
}
