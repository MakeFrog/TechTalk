import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/services/slack_notification_service.dart';
import 'package:techtalk/features/system/system.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class SplashEvent {
  /// 초기화 실행중인지 여부
  ///
  /// 초기화를 한번만 실행하기 위해 사용
  static bool isInitializing = false;

  /// 면접 주제 등 초기 호출 후 재사용할 데이터를 초기화한다.
  Future<void> initStaticData(WidgetRef ref) async {
    await StoredTopics.initialize();
    await techSetRepository.initSkills();
  }

  /// 유저 인증정보와 유저 정보를 토대로 라우팅을 분기한다.
  ///
  /// 인증 정보가 없으면 [SignInPage], 유저 정보가 없으면 [SignUpPage], 둘 다 있는 유저라면 [MainPage]로 라우팅한다.
  Future<void> routeByUserAuthAndData(WidgetRef ref) async {
    final response = await setEntryFlowUseCase.call();

    await response.fold(
      onSuccess: (_) async {

        await initStaticData(ref);
        final auth = ref.read(userAuthProvider);

        if (auth == null) {
          unawaited(
            SlackNotificationService.sendNotification(
              type: SlackNotificationType.login,
            ),
          );
          const SignInRoute().go(ref.context);
          return;
        }



        await ref.read(userInfoProvider.future).then(
          (userData) async {
            SlackNotificationService.updateUserInfo(userData);
            unawaited(
              SlackNotificationService.sendNotification(
                targetUserInfo: userData,
                type: SlackNotificationType.login,
              ),
            );
            if (userData == null) {
              const SignUpRoute().go(ref.context);
            } else {

              const MainRoute().go(ref.context);
            }
          },
        );
      },
      onFailure: (e) {
        log('버전 정보 및 네트워크 확인 실패');
      },
    );
  }
}
