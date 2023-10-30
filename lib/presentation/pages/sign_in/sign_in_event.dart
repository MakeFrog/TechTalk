import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

abstract interface class _SignInEvent {
  /// 구글 로그인을 진행한다.
  Future<void> onTapSignInWithGoogle(WidgetRef ref);

  /// 애플 로그인을 진행한다.
  Future<void> onTapSignInWithApple(WidgetRef ref);
}

mixin class SignInEvent implements _SignInEvent {
  /// 유저 데이터 여부 조회 후 회원가입을 완료했는지 여부에 따라 라우팅을 분기한다.
  Future<void> _routeByUserData(WidgetRef ref) async {
    await ref.read(appUserDataProvider.future).then(
      (userData) {
        if (userData == null || !userData.isCompleteSignUp) {
          const SignUpRoute().go(ref.context);
        } else {
          const MainRoute().go(ref.context);
        }
      },
    );
  }

  /// [provider]를 통해 OAuth 인증을 실행한다.
  Future<void> _signInOAuth(
    WidgetRef ref, {
    required UserAccountProvider provider,
  }) async {
    try {
      await ref
          .read(appUserAuthProvider.notifier)
          .signInOAuth(UserAccountProvider.google);
    } on FirebaseAuthException catch (e) {
      ToastService.show(
        toast: NormalToast(message: e.message ?? ''),
      );
    }
  }

  @override
  Future<void> onTapSignInWithGoogle(WidgetRef ref) async {
    await EasyLoading.show()
        .then(
          (_) => _signInOAuth(
            ref,
            provider: UserAccountProvider.google,
          ),
        )
        .then(
          (_) => _routeByUserData(ref),
        )
        .then(
          (_) => EasyLoading.dismiss(),
        );
  }

  @override
  Future<void> onTapSignInWithApple(WidgetRef ref) async {
    await EasyLoading.show()
        .then(
          (_) => _signInOAuth(
            ref,
            provider: UserAccountProvider.apple,
          ),
        )
        .then(
          (_) => _routeByUserData(ref),
        )
        .then(
          (_) => EasyLoading.dismiss(),
        );
  }
}
