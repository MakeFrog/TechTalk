import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

mixin class SignInPageEvent {
  Future<void> onTapSignInWithGoogle(WidgetRef ref) async {
    await EasyLoading.show()
        .then(
          (value) => ref
              .read(appUserAuthProvider.notifier)
              .signInOAuth(UserAccountProvider.google),
        )
        // TODO : 계정 정보 조회 후 회원가입이 필요하면 다른 라우트로 라우팅
        .then(
          (value) => const HomeRoute().go(ref.context),
        )
        .catchError(
          test: (error) => error is FirebaseAuthException,
          (e) => ToastService().show(
            toast: NormalToast(message: 'test'),
          ),
        )
        .catchError(
          (_) => ToastService().show(
            toast: NormalToast(message: '로그인 실패'),
          ),
        )
        .whenComplete(
          EasyLoading.dismiss,
        );
  }
}
