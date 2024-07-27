import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/system.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:url_launcher/url_launcher.dart';

class SetEntryFlowUseCase extends BaseNoParamUseCase<Result<void>> {
  SetEntryFlowUseCase(this._repository);

  final SystemRepository _repository;

  @override
  FutureOr<Result<void>> call() async {
    final versionInfo = await _repository.getVersionInfo();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final connectivityResult = await Connectivity().checkConnectivity();

    return versionInfo.fold(
      onSuccess: (version) async {
        final serverVersionCode = Version.parse(version.versionCode);
        final appVersionCode = Version.parse(packageInfo.version);

        // 시스템 종료 불가 + 점검중 or 공지 노출
        if (!version.isSystemAvailable) {
          if (version.notification != '') {
            showSystemIsNotAvailableNotificationModal(version.notification);
            return Result.failure(const SystemNotAvailableWithNotification());
          } else {
            showSystemIsNotAvailableModal();
            return Result.failure(const SystemOnMaintenanceException());
          }
        }

        /// 조건: 서버 버전이 현재 앱 버전보다 높다면
        /// 앱 업데이트 모달 노출
        if (serverVersionCode > appVersionCode) {
          if (version.needUpdate) {
            showNeedUpdateModal();
            return Result.failure(const SystemNeedUpdateException());
          } else {
            await showUpdateIsAvailable();
          }
        }

        return Result.success(null);
      },
      onFailure: (e) {
        /// 조건 : 네트워크가 연결이 안되어 있다면
        /// 네트워크 불안정 모달 노출
        if (!(connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi)) {
          showNetworkIsBadModal();
          return Result.failure(const SystemNetworkUnstable());
        }

        somethingIsWrongModal();
        return Result.failure(const SystemSomethingWrongException());
      },
    );
  }

  Future<void> showUpdateIsAvailable() async {
    await DialogService.asyncShow(
      dialog: AppDialog.dividedBtn(
        title: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_updateNotice),
        subTitle: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_techtalkUpdated),
        description: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_pleaseUpdateForLatestFeatures),
        leftBtnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.undefined_later),
        rightBtnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
        showContentImg: true,
        onLeftBtnClicked: () async {
          rootNavigatorKey.currentContext!.pop();
        },
        onRightBtnClicked: () async {
          rootNavigatorKey.currentContext!.pop();
          if (Platform.isIOS) {
            await launchUrl(
              Uri.parse(
                'https://apps.apple.com/kr/app/id6478161786',
              ),
              mode: LaunchMode.externalApplication,
            );
          } else if (Platform.isAndroid) {
            await launchUrl(
              Uri.parse(
                'https://play.google.com/store/apps/details?id=com.techtalk.ai',
              ),
              mode: LaunchMode.externalApplication,
            );
          }
        },
      ),
    );
  }

  void somethingIsWrongModal() {
    DialogService.show(
      dialog: AppDialog.singleBtn(
        title: rootNavigatorKey.currentContext!.tr(LocaleKeys.errors_error),
        description: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.errors_unknownErrorOccurred),
        btnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
        showContentImg: true,
        onBtnClicked: () {
          rootNavigatorKey.currentContext!.pop();
          exit(0);
        },
      ),
    );
  }

  void showSystemIsNotAvailableNotificationModal(String notification) {
    DialogService.show(
      dialog: AppDialog.singleBtn(
        title: rootNavigatorKey.currentContext!.tr(LocaleKeys.common_notice),
        subTitle: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_temporaryServiceRestriction),
        description: notification,
        btnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
        showContentImg: false,
        onBtnClicked: () {
          rootNavigatorKey.currentContext!.pop();
          exit(0);
        },
      ),
    );
  }

  void showSystemIsNotAvailableModal() {
    DialogService.show(
      dialog: AppDialog.singleBtn(
        title: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_maintenanceNotice),
        description: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_serviceLimitedForMaintenance),
        btnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
        showContentImg: true,
        onBtnClicked: () {
          rootNavigatorKey.currentContext!.pop();
          exit(0);
        },
      ),
    );
  }

  void showNetworkIsBadModal() {
    DialogService.show(
      dialog: AppDialog.singleBtn(
        title: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_networkUnstable),
        description: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_enableWiFiOrData),
        btnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
        showContentImg: true,
        onBtnClicked: () {
          rootNavigatorKey.currentContext!.pop();
          exit(0);
        },
      ),
    );
  }

  void showNeedUpdateModal() {
    DialogService.show(
      dialog: AppDialog.singleBtn(
        title: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_updateNotice),
        subTitle: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_techtalkUpdated),
        description: rootNavigatorKey.currentContext!
            .tr(LocaleKeys.undefined_pleaseUpdateForLatestFeatures),
        showContentImg: true,
        btnContent:
            rootNavigatorKey.currentContext!.tr(LocaleKeys.undefined_update),
        onBtnClicked: () async {
          rootNavigatorKey.currentContext!.pop();
          if (Platform.isIOS) {
            await launchUrl(
              Uri.parse(
                'https://apps.apple.com/kr/app/id6478161786',
              ),
              mode: LaunchMode.externalApplication,
            );
          } else if (Platform.isAndroid) {
            await launchUrl(
              Uri.parse(
                'https://play.google.com/store/apps/details?id=com.techtalk.ai',
              ),
              mode: LaunchMode.externalApplication,
            );
          }
        },
      ),
    );
  }
}
