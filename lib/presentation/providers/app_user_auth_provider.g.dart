// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isUserAuthorizedHash() => r'6f3c62c6234d4b4f8e97451777f4db49357672a0';

/// 현재 앱 사용자가 인증되었는지 여부
///
/// * 현재는 단순 유저정보가 있나 없나로 판단. 테스트 후 다른 조건이 필요한지 찾아볼 것
///
/// Copied from [isUserAuthorized].
@ProviderFor(isUserAuthorized)
final isUserAuthorizedProvider = AutoDisposeProvider<bool>.internal(
  isUserAuthorized,
  name: r'isUserAuthorizedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUserAuthorizedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsUserAuthorizedRef = AutoDisposeProviderRef<bool>;
String _$appUserAuthHash() => r'04b02c91e617cde5b9d9fb398ba66cce3b204125';

/// 앱 사용자 권한 프로바이더
///
/// 인증, 로그인, 로그아웃 등의 기능을 담당한다.
///
/// Copied from [AppUserAuth].
@ProviderFor(AppUserAuth)
final appUserAuthProvider = NotifierProvider<AppUserAuth, User?>.internal(
  AppUserAuth.new,
  name: r'appUserAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appUserAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppUserAuth = Notifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
