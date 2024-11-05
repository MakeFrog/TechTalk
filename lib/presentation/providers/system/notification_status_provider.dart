import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

part 'notification_status_provider.g.dart';

@Riverpod(keepAlive: true)
class NotificationStatus extends _$NotificationStatus {
  @override
  Future<bool> build() async {
    return Permission.notification.isGranted;
  }

  Future<void> detectStatusOnResumed() async {
    final isNotificationGranted = await Permission.notification.isGranted;

    /// 설정 값과 현재 상태 값이 상이하다면
    /// 상태 업데이트
    if (state.hasValue && state.requireValue != isNotificationGranted) {
      await update((_) => isNotificationGranted);
    }
  }

  Future<void> toggle() async {
    final isGranted = state.valueOrNull;
    if (isGranted == null) return;
    if (isGranted) {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          title: '알람 설정',
          subTitle: '알람을 비활성화 하기 위해 권한을 해제 해주세요',
          leftBtnContent: tr(LocaleKeys.common_cancel),
          showContentImg: false,
          rightBtnContent: tr(LocaleKeys.permission_setUp),
          onRightBtnClicked: () async {
            (await navigationContext).pop();
            await AppSettings.openAppSettings();
          },
          onLeftBtnClicked: () async {
            (await navigationContext).pop();
          },
        ),
      );
    } else {
      await FirebaseMessaging.instance.requestPermission();
      final result = await Permission.notification.request();
      if (result.isGranted) {
        await update((_) => true);
      } else {
        {
          DialogService.show(
            dialog: AppDialog.dividedBtn(
              title: tr(LocaleKeys.permission_permissionNeeded),
              subTitle: '알람 수신을 위해서는 권한 동의가 필요해요',
              leftBtnContent: tr(LocaleKeys.common_cancel),
              showContentImg: false,
              rightBtnContent: tr(LocaleKeys.permission_setUp),
              onRightBtnClicked: () async {
                (await navigationContext).pop();
                await AppSettings.openAppSettings();
              },
              onLeftBtnClicked: () async {
                (await navigationContext).pop();
              },
            ),
          );
        }
      }
    }
  }
}
