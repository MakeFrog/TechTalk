import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class SignInEvent {
  ///
  /// 유저 데이터 존재 여부에 따라 라우팅을 분기한다.
  ///
  Future<void> _routeByUserState(WidgetRef ref,
      {required UserAccountProvider accountProvider}) async {
    return ref.watch(userInfoProvider.future).then(
      (userData) async {
        if (userData != null) {
          unawaited(FirebaseAnalytics.instance
              .logLogin(loginMethod: accountProvider.name));
          const MainRoute().go(ref.context);
        } else {
          unawaited(FirebaseAnalytics.instance
              .logSignUp(signUpMethod: accountProvider.name));
          const SignUpRoute().go(ref.context);
        }
      },
    );
  }

  ///
  /// OAuth 인증을 실행
  ///
  Future<void> _signInOAuth(
    WidgetRef ref, {
    required UserAccountProvider provider,
  }) async {
    try {
      await EasyLoading.show().then(
        (_) {
          return ref.read(userAuthProvider.notifier).signInOAuth(provider);
        },
      ).then(
        (_) => _routeByUserState(ref, accountProvider: provider),
      );
    } finally {
      await EasyLoading.dismiss();
    }
  }

  ///
  /// 소셜 로그인 버튼을 클릭 했을 때
  ///
  Future<void> onSocialSignInBtnTapped(WidgetRef ref,
      {required UserAccountProvider socialAccountProvider}) async {
    await _signInOAuth(ref, provider: socialAccountProvider);
  }
}
