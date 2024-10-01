// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessageHistoryHash() =>
    r'1954b45bcc2b094af9903b0c01506dbefab0f91d';

/// See also [ChatMessageHistory].
@ProviderFor(ChatMessageHistory)
final chatMessageHistoryProvider = AutoDisposeAsyncNotifierProvider<
    ChatMessageHistory, List<BaseChatEntity>>.internal(
  ChatMessageHistory.new,
  name: r'chatMessageHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatMessageHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatMessageHistory = AutoDisposeAsyncNotifier<List<BaseChatEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
