import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';

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
        SnackBarService.showSnackBar('네트워크 상태를 추적해주세요');
      }
    });
  }
}
