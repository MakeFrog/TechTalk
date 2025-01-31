import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

mixin class AnalyzeYoutubeProgressEvent {
  ///
  /// 알림 활성화 스위치 버튼이 클릭 되었을 때
  ///
  void onNotificationSwitchBtnTapped(WidgetRef ref) {
    ref.read(notificationStatusProvider.notifier).toggle();
  }

  /// 화면 이탈 버튼이 클릭 되었을 때
  Future<void> onExitPageBtnTapped(WidgetRef ref) async {
    final isGranted = await ref.read(notificationStatusProvider.future);

    if (isGranted) {
      ref.context.pop();
    } else {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          title: '알림 권한 필요',
          description: '알림을 허용하지 않으면 업로드 완료 알림을 받을 수 없어요',
          leftBtnContent: '나가기',
          showContentImg: false,
          rightBtnContent: '허용하기',
          onRightBtnClicked: () {
            ref
                .read(notificationStatusProvider.notifier)
                .toggle(showDialog: false);
          },
          onLeftBtnClicked: () {
            ref.context.pop();
            if (ref.context.canPop()) {
              ref.context.pop();
            }
          },
        ),
      );
    }
  }
}
