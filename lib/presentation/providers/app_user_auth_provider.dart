import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/auth/auth.dart';

part 'app_user_auth_provider.g.dart';

/// 앱 사용자 권한 프로바이더
///
/// 인증, 로그인, 로그아웃 등의 기능을 담당한다.
@Riverpod(keepAlive: true)
class AppUserAuth extends _$AppUserAuth {
  // 사용자 계정 정보 변경 구독 객체
  // 사용자 인증 정보가 변경되면 프로바이더를 갱신한다.
  StreamSubscription<User?> get _authStateSubscription =>
      FirebaseAuth.instance.authStateChanges().listen(
        (event) {
          state = event;
        },
        onDone: () => print('firebase auth onDone'),
        onError: (e) => print('firebase auth onError'),
      );

  @override
  User? build() {
    final authState = _authStateSubscription;

    ref.onDispose(() {
      authState.cancel();
    });

    return FirebaseAuth.instance.currentUser;
  }

  /// OAuth 인증을 통해 로그인한다.
  Future<void> signInOAuth(UserAccountProvider provider) async {
    await signInOAuthUseCase(provider);
  }

  /// 로그아웃을 시도한다.
  Future<void> signOut() async {
    await signOutUseCase();
  }
}

/// 현재 앱 사용자가 인증되었는지 여부
///
/// * 현재는 단순 유저정보가 있나 없나로 판단. 테스트 후 다른 조건이 필요한지 찾아볼 것
@riverpod
bool isUserAuthorized(IsUserAuthorizedRef ref) =>
    ref.watch(appUserAuthProvider) != null;
