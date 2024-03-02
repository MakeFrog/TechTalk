import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:techtalk/core/helper/date_time_extension.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/providers/system/detect_network_connectivity_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class MainEvent {
  void onTapBottomNavigationItem(
    WidgetRef ref, {
    required int index,
  }) {
    ref.read(mainBottomNavigationProvider.notifier).tab =
        MainNavigationTab.values[index];
  }

  ///
  /// 네트워크 변화 실시간 탐지 모듈 실행
  ///
  void activateNetworkConnectivityDetector(WidgetRef ref) {
    ref.read(detectNetworkConnectivityProvider);
  }

  ///
  /// 조건별로 앱 평가 다이어로그 노출
  ///
  Future<void> alertRateAppDialogIfNeeded(WidgetRef ref) async {
    final user = ref.read(userInfoProvider).requireValue!;

    if (user.signUpDate.isOneMonthOrMorePassedFromNow &&
        user.isReviewRequestAvailable) {
      final InAppReview inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        unawaited(inAppReview.requestReview());
        final response = await disableReviewAvailableStateUseCase.call();
        response.fold(
          onSuccess: (_) {
            log('앱 평가 다이어로그 노출 가능 상태 비활성화');
          },
          onFailure: (e) {
            log('앱 평가 다이어로그 노출 가능 상태 변화 실패 : ${e}');
          },
        );
      }
    }
  }
}
