import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
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

  Future<void> toggle() async {
    final isGranted = state.valueOrNull;
    if (isGranted == null) return;
    if (isGranted) {
      await update((_) => false);
    } else {
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

                if (await Permission.notification.isGranted) {
                  await update((_) => true);
                }
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
