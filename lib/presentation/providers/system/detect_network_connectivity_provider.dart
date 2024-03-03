import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

part 'detect_network_connectivity_provider.g.dart';

@Riverpod(keepAlive: true)
class DetectNetworkConnectivity extends _$DetectNetworkConnectivity {
  @override
  void build() {
    final connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.ethernet ||
            result == ConnectivityResult.other) {
          listenNetwork(connectivity);
        }
      },
    );
  }

  void listenNetwork(Connectivity connectivity) {
    connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        DialogService.show(
          dialog: AppDialog.dividedBtn(
            title: '네트워크 불안정',
            subTitle: 'Wi-Fi 또는 데이터를 활성화 해주세요.',
            leftBtnContent: '취소',
            showContentImg: false,
            rightBtnContent: '설정하기',
            onRightBtnClicked: () async {
              rootNavigatorKey.currentContext?.pop();
              await AppSettings.openAppSettings(
                type: AppSettingsType.wifi,
              );
            },
            onLeftBtnClicked: () {
              rootNavigatorKey.currentContext?.pop();
            },
          ),
        );
        SnackBarService.showSnackBar('네트워크 상태를 추적해주세요');
      }
    });
  }
}
