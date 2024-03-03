import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/modules/base_use_case/base_no_param_use_case.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/system/repositories/system_repository.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
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
        title: '업데이트 안내',
        subTitle: '테크톡이 업데이트 되었습니다!',
        description: '최신 기능을 이용하기 위해 업데이트를 진행해주세요',
        leftBtnContent: '다음에',
        rightBtnContent: '확인',
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
                'https://play.google.com/store/apps/details?id=com.techtalk',
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
        title: '오류',
        description: '알 수 없는 오류가 발생했습니다',
        btnContent: '확인',
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
        title: '공지',
        subTitle: '사용 임시 제한',
        description: notification,
        btnContent: '확인',
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
        title: '시스템 점검 안내',
        description: '시스템 점검으로 서비스 이용이 제한됩니다',
        btnContent: '확인',
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
        title: '네트워크 불안정',
        description: 'Wi-Fi 또는 데이터를 활성화 해주세요.',
        btnContent: '확인',
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
        title: '업데이트 안내',
        subTitle: '테크톡이 업데이트 되었습니다!',
        description: '최신 기능을 이용하기 위해 업데이트를 진행해주세요',
        showContentImg: true,
        btnContent: '업데이트',
        onBtnClicked: () async {
          rootNavigatorKey.currentContext!.pop();
          if (Platform.isIOS) {
            await launchUrl(
              Uri.parse(
                'https://apps.apple.com/kr/app/%EC%88%9C%EC%82%AD/id1671820197',
              ),
              mode: LaunchMode.externalApplication,
            );
          } else if (Platform.isAndroid) {
            await launchUrl(
              Uri.parse(
                'https://play.google.com/store/apps/details?id=com.soon_sak',
              ),
              mode: LaunchMode.externalApplication,
            );
          }
        },
      ),
    );
  }
}
