// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatQnAsHash() => r'901d18692d9d530fa24c50adca51b7c619f02a97';

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

abstract class _$ChatQnAs
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatQnaEntity>> {
  late final ChatRoomEntity room;

  FutureOr<List<ChatQnaEntity>> build(
    ChatRoomEntity room,
  );
}

/// See also [ChatQnAs].
@ProviderFor(ChatQnAs)
const chatQnAsProvider = ChatQnAsFamily();

/// See also [ChatQnAs].
class ChatQnAsFamily extends Family<AsyncValue<List<ChatQnaEntity>>> {
  /// See also [ChatQnAs].
  const ChatQnAsFamily();

  /// See also [ChatQnAs].
  ChatQnAsProvider call(
    ChatRoomEntity room,
  ) {
    return ChatQnAsProvider(
      room,
    );
  }

  @override
  ChatQnAsProvider getProviderOverride(
    covariant ChatQnAsProvider provider,
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
  String? get name => r'chatQnAsProvider';
}

/// See also [ChatQnAs].
class ChatQnAsProvider extends AutoDisposeAsyncNotifierProviderImpl<ChatQnAs,
    List<ChatQnaEntity>> {
  /// See also [ChatQnAs].
  ChatQnAsProvider(
    ChatRoomEntity room,
  ) : this._internal(
          () => ChatQnAs()..room = room,
          from: chatQnAsProvider,
          name: r'chatQnAsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatQnAsHash,
          dependencies: ChatQnAsFamily._dependencies,
          allTransitiveDependencies: ChatQnAsFamily._allTransitiveDependencies,
          room: room,
        );

  ChatQnAsProvider._internal(
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
  FutureOr<List<ChatQnaEntity>> runNotifierBuild(
    covariant ChatQnAs notifier,
  ) {
    return notifier.build(
      room,
    );
  }

  @override
  Override overrideWith(ChatQnAs Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatQnAsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChatQnAs, List<ChatQnaEntity>>
      createElement() {
    return _ChatQnAsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatQnAsProvider && other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatQnAsRef on AutoDisposeAsyncNotifierProviderRef<List<ChatQnaEntity>> {
  /// The parameter `room` of this provider.
  ChatRoomEntity get room;
}

class _ChatQnAsProviderElement extends AutoDisposeAsyncNotifierProviderElement<
    ChatQnAs, List<ChatQnaEntity>> with ChatQnAsRef {
  _ChatQnAsProviderElement(super.provider);

  @override
  ChatRoomEntity get room => (origin as ChatQnAsProvider).room;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
