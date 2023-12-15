import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/auth/auth.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'user_auth_provider.g.dart';

/// 앱 사용자 권한 프로바이더
@Riverpod(keepAlive: true)
class UserAuth extends _$UserAuth {
  @override
  User? build() {
    return FirebaseAuth.instance.currentUser;
  }

  /// OAuth 인증을 통해 로그인한다.
  Future<void> signInOAuth(UserAccountProvider provider) async {
    final result = await signInOAuthUseCase(provider);
    result.fold(
      onSuccess: (value) {
        state = value.user;
      },
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );
        throw e;
      },
    );
  }

  /// 로그아웃을 시도한다.
  Future<void> signOut() async {
    final result = await signOutUseCase();
    result.fold(
      onSuccess: (value) => ref.invalidateSelf(),
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );
        throw e;
      },
    );
  }
}
