// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userInfoHash() => r'3879bcff65f96356bd3db88c8f810c879d19d4da';

/// See also [UserInfo].
@ProviderFor(UserInfo)
final userInfoProvider = AsyncNotifierProvider<UserInfo, UserEntity?>.internal(
  UserInfo.new,
  name: r'userInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userInfoHash,
  dependencies: <ProviderOrFamily>[userAuthProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    userAuthProvider,
    ...?userAuthProvider.allTransitiveDependencies
  },
);

typedef _$UserInfo = AsyncNotifier<UserEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
