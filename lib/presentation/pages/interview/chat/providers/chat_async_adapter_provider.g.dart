// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_async_adapter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatAsyncAdapterHash() => r'aedc70ed2d6fc2e3da6caef9e0aca3f708fa347c';

///
/// [chatQnasProvider][chatMessageHistoryProvider]
/// 위 provider의 async build 여부를 확인하여 [AsyncValue] 인스턴스를 리턴
/// [ChatPage] 위젯에서 사용됨.
///
///
/// Copied from [ChatAsyncAdapter].
@ProviderFor(ChatAsyncAdapter)
final chatAsyncAdapterProvider =
    AutoDisposeNotifierProvider<ChatAsyncAdapter, AsyncValue>.internal(
  ChatAsyncAdapter.new,
  name: r'chatAsyncAdapterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatAsyncAdapterHash,
  dependencies: <ProviderOrFamily>[
    chatQnasProvider,
    chatMessageHistoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    chatQnasProvider,
    ...?chatQnasProvider.allTransitiveDependencies,
    chatMessageHistoryProvider,
    ...?chatMessageHistoryProvider.allTransitiveDependencies
  },
);

typedef _$ChatAsyncAdapter = AutoDisposeNotifier<AsyncValue>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
