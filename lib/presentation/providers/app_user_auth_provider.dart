import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/auth/auth.dart';

part 'app_user_auth_provider.g.dart';

/// 앱 사용자 권한 프로바이더
///
/// 인증, 로그인, 로그아웃 등의 기능을 담당한다.
@Riverpod(keepAlive: true)
class AppUserAuth extends _$AppUserAuth {
  final _signInOAuthUseCase = GetIt.I<SignInOAuthUseCase>();
  final _signOutUseCase = GetIt.I<SignOutUseCase>();

  @override
  User? build() {
    return FirebaseAuth.instance.currentUser;
  }

  /// OAuth 인증을 통해 로그인한다.
  Future<void> signInOAuth(UserAccountProvider provider) async {
    await _signInOAuthUseCase(provider);
    ref.invalidateSelf();
  }

  /// 로그아웃을 시도한다.
  Future<void> signOut() async {
    await _signOutUseCase();
    ref.invalidateSelf();
  }
}

/// 현재 앱 사용자가 인증되었는지 여부
///
/// * 현재는 단순 유저 인증 정보가 있나 없나로 판단. 테스트 후 다른 조건이 필요한지 찾아볼 것
@riverpod
bool isUserAuthorized(IsUserAuthorizedRef ref) =>
    ref.watch(appUserAuthProvider) != null;
