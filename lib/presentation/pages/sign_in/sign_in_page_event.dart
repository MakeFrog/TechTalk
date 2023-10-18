import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

mixin class SignInPageEvent {
  /// 유저 데이터 여부 조회 후 회원가입을 완료했는지 여부에 따라 라우팅을 분기한다.
  Future<void> _routeByUserData(WidgetRef ref) async {
    await ref.read(appUserDataProvider.future).then(
      (data) {
        if (data != null) {
          if (data.isCompleteSignUp) {
            const HomeRoute().go(ref.context);
          } else {
            const SignUpRoute().go(ref.context);
          }
        }
      },
    );
  }

  Future<void> onTapSignInWithGoogle(WidgetRef ref) async {
    await EasyLoading.show();

    try {
      // 계정 등록 or 로그인
      await ref
          .read(appUserAuthProvider.notifier)
          .signInOAuth(UserAccountProvider.google);

      await _routeByUserData(ref);
    } on Exception catch (e) {
      ToastService.show(
        toast: NormalToast(message: '$e'),
      );
    } finally {
      unawaited(
        EasyLoading.dismiss(),
      );
    }
  }

  Future<void> onTapSignInWithApple(WidgetRef ref) async {
    await EasyLoading.show();

    try {
      // 계정 등록 or 로그인
      await ref
          .read(appUserAuthProvider.notifier)
          .signInOAuth(UserAccountProvider.apple);

      await _routeByUserData(ref);
    } on Exception catch (e) {
      ToastService.show(
        toast: NormalToast(message: '$e'),
      );
    } finally {
      unawaited(
        EasyLoading.dismiss(),
      );
    }
  }
}
