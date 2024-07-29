import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/system.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/providers/system/detect_network_connectivity_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class MainEvent {
  void onTapBottomNavigationItem(
    WidgetRef ref, {
    required int index,
  }) {
    ref.read(mainBottomNavigationProvider.notifier).tab = MainNavigationTab.values[index];
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

    if (user.signUpDate.isOneMonthOrMorePassedFromNow && user.isReviewRequestAvailable) {
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

  ///
  /// 조건에따라 로컬스토리지 캐시를 삭제
  ///
  Future<void> clearTopicCacheOnCondition() async {
    final response = await systemRepository.getStoredLocale();

    await response.fold(
      onSuccess: (data) async {
        /// 만약 마지막 스토리지에 저장된 locale이
        /// 현재 locale과 다르다면 systembox 스토리지 데이터 삭제
        if (data == null || AppLocale.currentLocale == data) return;
        await AppLocal.qnasBox.clear();
        unawaited(_storeLocaleToStorage());
      },
      onFailure: (e) {
        log('Localization에 따른 qna 캐싱 초기화 작업 실패 : ${e}');
      },
    );
  }

  ///
  /// 로컬 스토리지에 현재 Locale 정보 삭제
  ///
  Future<void> _storeLocaleToStorage() async {
    final response = await systemRepository.storeLocale(AppLocale.currentLocale);

    response.fold(onSuccess: (_) {
      log('로컬 스토리지에 locale 정보 저장');
    }, onFailure: (e) {
      log('로컬 스토리 locale 저장 정보 실패');
    });
  }
}
