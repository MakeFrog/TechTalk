// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessageHistoryHash() =>
    r'd4d23305c45f2d9c3a4e46038d7755cb59720644';

/// See also [ChatMessageHistory].
@ProviderFor(ChatMessageHistory)
final chatMessageHistoryProvider = AutoDisposeAsyncNotifierProvider<
    ChatMessageHistory, List<ChatMessageEntity>>.internal(
  ChatMessageHistory.new,
  name: r'chatMessageHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatMessageHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatMessageHistory
    = AutoDisposeAsyncNotifier<List<ChatMessageEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
