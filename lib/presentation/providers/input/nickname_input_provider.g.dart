// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname_input_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nicknameInputHash() => r'dff2221c672a1b270e641834bc5b2192e8dbcefc';

/// See also [NicknameInput].
@ProviderFor(NicknameInput)
final nicknameInputProvider =
    AutoDisposeNotifierProvider<NicknameInput, String?>.internal(
  NicknameInput.new,
  name: r'nicknameInputProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nicknameInputHash,
  dependencies: <ProviderOrFamily>[userInfoProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    userInfoProvider,
    ...?userInfoProvider.allTransitiveDependencies
  },
);

typedef _$NicknameInput = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
