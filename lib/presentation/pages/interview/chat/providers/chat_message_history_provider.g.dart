// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessageHistoryHash() =>
    r'c3641b4dc799678a5ca0e4c790ab56c5c5ec0c83';

/// See also [ChatMessageHistory].
@ProviderFor(ChatMessageHistory)
final chatMessageHistoryProvider = AutoDisposeAsyncNotifierProvider<
    ChatMessageHistory, List<ChatMessageEntity>>.internal(
  ChatMessageHistory.new,
  name: r'chatMessageHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatMessageHistoryHash,
  dependencies: <ProviderOrFamily>[selectedChatRoomProvider, chatQnasProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedChatRoomProvider,
    ...?selectedChatRoomProvider.allTransitiveDependencies,
    chatQnasProvider,
    ...?chatQnasProvider.allTransitiveDependencies
  },
);

typedef _$ChatMessageHistory
    = AutoDisposeAsyncNotifier<List<ChatMessageEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
