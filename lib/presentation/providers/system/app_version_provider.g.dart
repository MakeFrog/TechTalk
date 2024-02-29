// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appVersionHash() => r'335be4412f9320026843107d59006d6be62592ca';

///
/// 앱의 버전 정보를 관리하는 provider
///
///
/// Copied from [AppVersion].
@ProviderFor(AppVersion)
final appVersionProvider =
    AsyncNotifierProvider<AppVersion, VersionEntity>.internal(
  AppVersion.new,
  name: r'appVersionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appVersionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppVersion = AsyncNotifier<VersionEntity>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
