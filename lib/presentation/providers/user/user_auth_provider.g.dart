// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userAuthHash() => r'26d36dfbbcde7ea1d2731ab4f9b7d2a6ef17a3d4';

/// 앱 사용자 권한 프로바이더
///
/// Copied from [UserAuth].
@ProviderFor(UserAuth)
final userAuthProvider = NotifierProvider<UserAuth, User?>.internal(
  UserAuth.new,
  name: r'userAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserAuth = Notifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
