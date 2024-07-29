import 'dart:async';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/modules/local/app_local.dart';
import 'package:techtalk/features/system/system.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class StudyTopicSelectionEvent {
  ///
  /// 면접 주제 카드가 클릭 되었을 때
  ///
  void onTapCard(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    FirebaseAnalytics.instance.logEvent(
      name: 'Go to Study Detail',
      parameters: {
        'user_id': ref.read(userInfoProvider).requireValue?.uid,
        'user_name': ref.read(userInfoProvider).requireValue?.nickname,
        'topic': topic.text,
      },
    );
    StudyRoute(topic).push(rootNavigatorKey.currentContext!);
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
        if (data == null || AppLocale.currentLocal == data) return;
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
    final response = await systemRepository.storeLocale(AppLocale.currentLocal);

    response.fold(onSuccess: (_) {
      log('로컬 스토리지에 locale 정보 저장');
    }, onFailure: (e) {
      log('로컬 스토리 locale 저장 정보 실패');
    });
  }
}
