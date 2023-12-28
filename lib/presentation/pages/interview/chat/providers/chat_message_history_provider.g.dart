// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMessageHistoryHash() =>
    r'61de80330db8004e3ec7a9ccdc58b4649187960d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChatMessageHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatMessageEntity>> {
  late final ChatRoomEntity room;

  FutureOr<List<ChatMessageEntity>> build(
    ChatRoomEntity room,
  );
}

/// See also [ChatMessageHistory].
@ProviderFor(ChatMessageHistory)
const chatMessageHistoryProvider = ChatMessageHistoryFamily();

/// See also [ChatMessageHistory].
class ChatMessageHistoryFamily
    extends Family<AsyncValue<List<ChatMessageEntity>>> {
  /// See also [ChatMessageHistory].
  const ChatMessageHistoryFamily();

  /// See also [ChatMessageHistory].
  ChatMessageHistoryProvider call(
    ChatRoomEntity room,
  ) {
    return ChatMessageHistoryProvider(
      room,
    );
  }

  @override
  ChatMessageHistoryProvider getProviderOverride(
    covariant ChatMessageHistoryProvider provider,
  ) {
    return call(
      provider.room,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatMessageHistoryProvider';
}

/// See also [ChatMessageHistory].
class ChatMessageHistoryProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChatMessageHistory, List<ChatMessageEntity>> {
  /// See also [ChatMessageHistory].
  ChatMessageHistoryProvider(
    ChatRoomEntity room,
  ) : this._internal(
          () => ChatMessageHistory()..room = room,
          from: chatMessageHistoryProvider,
          name: r'chatMessageHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMessageHistoryHash,
          dependencies: ChatMessageHistoryFamily._dependencies,
          allTransitiveDependencies:
              ChatMessageHistoryFamily._allTransitiveDependencies,
          room: room,
        );

  ChatMessageHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.room,
  }) : super.internal();

  final ChatRoomEntity room;

  @override
  FutureOr<List<ChatMessageEntity>> runNotifierBuild(
    covariant ChatMessageHistory notifier,
  ) {
    return notifier.build(
      room,
    );
  }

  @override
  Override overrideWith(ChatMessageHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatMessageHistoryProvider._internal(
        () => create()..room = room,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        room: room,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatMessageHistory,
      List<ChatMessageEntity>> createElement() {
    return _ChatMessageHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessageHistoryProvider && other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatMessageHistoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<ChatMessageEntity>> {
  /// The parameter `room` of this provider.
  ChatRoomEntity get room;
}

class _ChatMessageHistoryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatMessageHistory,
        List<ChatMessageEntity>> with ChatMessageHistoryRef {
  _ChatMessageHistoryProviderElement(super.provider);

  @override
  ChatRoomEntity get room => (origin as ChatMessageHistoryProvider).room;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
