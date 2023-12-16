// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_progress_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatProgressStateHash() => r'bfc605d14e3c69b3a86df80fe2be527f81362858';

/// See also [ChatProgressState].
@ProviderFor(ChatProgressState)
final chatProgressStateProvider =
    AutoDisposeNotifierProvider<ChatProgressState, ChatProgress>.internal(
  ChatProgressState.new,
  name: r'chatProgressStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatProgressStateHash,
  dependencies: <ProviderOrFamily>[
    chatPageRouteArgProvider,
    chatHistoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    chatPageRouteArgProvider,
    ...?chatPageRouteArgProvider.allTransitiveDependencies,
    chatHistoryProvider,
    ...?chatHistoryProvider.allTransitiveDependencies
  },
);

typedef _$ChatProgressState = AutoDisposeNotifier<ChatProgress>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
