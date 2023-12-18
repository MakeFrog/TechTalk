// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_of_room_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatHistoryOfRoomHash() => r'0dbaa0829f78d55d63fe384537b048a74e5039d1';

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

abstract class _$ChatHistoryOfRoom
    extends BuildlessAutoDisposeAsyncNotifier<List<MessageEntity>> {
  late final ChatRoomEntity room;

  FutureOr<List<MessageEntity>> build(
    ChatRoomEntity room,
  );
}

/// See also [ChatHistoryOfRoom].
@ProviderFor(ChatHistoryOfRoom)
const chatHistoryOfRoomProvider = ChatHistoryOfRoomFamily();

/// See also [ChatHistoryOfRoom].
class ChatHistoryOfRoomFamily extends Family<AsyncValue<List<MessageEntity>>> {
  /// See also [ChatHistoryOfRoom].
  const ChatHistoryOfRoomFamily();

  /// See also [ChatHistoryOfRoom].
  ChatHistoryOfRoomProvider call(
    ChatRoomEntity room,
  ) {
    return ChatHistoryOfRoomProvider(
      room,
    );
  }

  @override
  ChatHistoryOfRoomProvider getProviderOverride(
    covariant ChatHistoryOfRoomProvider provider,
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
  String? get name => r'chatHistoryOfRoomProvider';
}

/// See also [ChatHistoryOfRoom].
class ChatHistoryOfRoomProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChatHistoryOfRoom, List<MessageEntity>> {
  /// See also [ChatHistoryOfRoom].
  ChatHistoryOfRoomProvider(
    ChatRoomEntity room,
  ) : this._internal(
          () => ChatHistoryOfRoom()..room = room,
          from: chatHistoryOfRoomProvider,
          name: r'chatHistoryOfRoomProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatHistoryOfRoomHash,
          dependencies: ChatHistoryOfRoomFamily._dependencies,
          allTransitiveDependencies:
              ChatHistoryOfRoomFamily._allTransitiveDependencies,
          room: room,
        );

  ChatHistoryOfRoomProvider._internal(
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
  FutureOr<List<MessageEntity>> runNotifierBuild(
    covariant ChatHistoryOfRoom notifier,
  ) {
    return notifier.build(
      room,
    );
  }

  @override
  Override overrideWith(ChatHistoryOfRoom Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatHistoryOfRoomProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChatHistoryOfRoom,
      List<MessageEntity>> createElement() {
    return _ChatHistoryOfRoomProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatHistoryOfRoomProvider && other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatHistoryOfRoomRef
    on AutoDisposeAsyncNotifierProviderRef<List<MessageEntity>> {
  /// The parameter `room` of this provider.
  ChatRoomEntity get room;
}

class _ChatHistoryOfRoomProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatHistoryOfRoom,
        List<MessageEntity>> with ChatHistoryOfRoomRef {
  _ChatHistoryOfRoomProviderElement(super.provider);

  @override
  ChatRoomEntity get room => (origin as ChatHistoryOfRoomProvider).room;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
