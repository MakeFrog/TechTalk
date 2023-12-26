// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_qnas_of_room_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$interviewQnAsOfRoomHash() =>
    r'0861f2071371d292a3cbb99fb5f8a6c131f2da4a';

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

abstract class _$InterviewQnAsOfRoom
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatQnaEntity>> {
  late final ChatRoomEntity room;

  FutureOr<List<ChatQnaEntity>> build(
    ChatRoomEntity room,
  );
}

/// See also [InterviewQnAsOfRoom].
@ProviderFor(InterviewQnAsOfRoom)
const interviewQnAsOfRoomProvider = InterviewQnAsOfRoomFamily();

/// See also [InterviewQnAsOfRoom].
class InterviewQnAsOfRoomFamily
    extends Family<AsyncValue<List<ChatQnaEntity>>> {
  /// See also [InterviewQnAsOfRoom].
  const InterviewQnAsOfRoomFamily();

  /// See also [InterviewQnAsOfRoom].
  InterviewQnAsOfRoomProvider call(
    ChatRoomEntity room,
  ) {
    return InterviewQnAsOfRoomProvider(
      room,
    );
  }

  @override
  InterviewQnAsOfRoomProvider getProviderOverride(
    covariant InterviewQnAsOfRoomProvider provider,
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
  String? get name => r'interviewQnAsOfRoomProvider';
}

/// See also [InterviewQnAsOfRoom].
class InterviewQnAsOfRoomProvider extends AutoDisposeAsyncNotifierProviderImpl<
    InterviewQnAsOfRoom, List<ChatQnaEntity>> {
  /// See also [InterviewQnAsOfRoom].
  InterviewQnAsOfRoomProvider(
    ChatRoomEntity room,
  ) : this._internal(
          () => InterviewQnAsOfRoom()..room = room,
          from: interviewQnAsOfRoomProvider,
          name: r'interviewQnAsOfRoomProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$interviewQnAsOfRoomHash,
          dependencies: InterviewQnAsOfRoomFamily._dependencies,
          allTransitiveDependencies:
              InterviewQnAsOfRoomFamily._allTransitiveDependencies,
          room: room,
        );

  InterviewQnAsOfRoomProvider._internal(
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
    covariant InterviewQnAsOfRoom notifier,
  ) {
    return notifier.build(
      room,
    );
  }

  @override
  Override overrideWith(InterviewQnAsOfRoom Function() create) {
    return ProviderOverride(
      origin: this,
      override: InterviewQnAsOfRoomProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<InterviewQnAsOfRoom,
      List<ChatQnaEntity>> createElement() {
    return _InterviewQnAsOfRoomProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InterviewQnAsOfRoomProvider && other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InterviewQnAsOfRoomRef
    on AutoDisposeAsyncNotifierProviderRef<List<ChatQnaEntity>> {
  /// The parameter `room` of this provider.
  ChatRoomEntity get room;
}

class _InterviewQnAsOfRoomProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<InterviewQnAsOfRoom,
        List<ChatQnaEntity>> with InterviewQnAsOfRoomRef {
  _InterviewQnAsOfRoomProviderElement(super.provider);

  @override
  ChatRoomEntity get room => (origin as InterviewQnAsOfRoomProvider).room;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
