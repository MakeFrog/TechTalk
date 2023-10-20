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
  Future<void> onTapSignInWithGoogle(WidgetRef ref) async {
    await EasyLoading.show();

    try {
      // 계정 등록 or 로그인
      await ref
          .read(appUserAuthProvider.notifier)
          .signInOAuth(UserAccountProvider.google);

      // 계정 데이터 확인 후 데이터 유무에 따라 라우팅 분기
      await ref.read(appUserDataProvider.future).then(
        (data) {
          if (data == null) {
            const SignUpRoute().go(ref.context);
          } else {
            const HomeRoute().go(ref.context);
          }
        },
      );
    } on Exception catch (e) {
      // TODO : usecase에서 에러를 처리
      //   // 계정 등록 or 로그인 실패 시
      // .catchError(
      // test: (error) => error is FirebaseAuthException,
      // (e) => ToastService().show(
      // toast: NormalToast(message: 'test'),
      // ),
      // )
      // // 불특정 이유로 로그인 실패 시
      //     .catchError(
      // (_) => ToastService().show(
      // toast: NormalToast(message: '로그인 실패'),
      // ),
      // )
      ToastService().show(
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

      // 계정 데이터 확인 후 데이터 유무에 따라 라우팅 분기
      await ref.read(appUserDataProvider.future).then(
        (data) {
          if (data == null) {
            const SignUpRoute().go(ref.context);
          } else {
            const HomeRoute().go(ref.context);
          }
        },
      );
    } on Exception catch (e) {
      ToastService().show(
        toast: NormalToast(message: '$e'),
      );
    } finally {
      unawaited(
        EasyLoading.dismiss(),
      );
    }
  }
}
