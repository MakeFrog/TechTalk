// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatHistoryHash() => r'7b9e12c91ed8dd6bff4d6b0807529188ef87ac8b';

/// See also [ChatHistory].
@ProviderFor(ChatHistory)
final chatHistoryProvider =
    AutoDisposeAsyncNotifierProvider<ChatHistory, List<MessageEntity>>.internal(
  ChatHistory.new,
  name: r'chatHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatHistoryHash,
  dependencies: <ProviderOrFamily>[chatPageRouteArgProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    chatPageRouteArgProvider,
    ...?chatPageRouteArgProvider.allTransitiveDependencies
  },
);

typedef _$ChatHistory = AutoDisposeAsyncNotifier<List<MessageEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
