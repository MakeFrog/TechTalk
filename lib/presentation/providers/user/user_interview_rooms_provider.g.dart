// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interview_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userInterviewRoomsHash() =>
    r'b6235840c48fefc8378feb173aa4d48afc2a061d';

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

abstract class _$UserInterviewRooms
    extends BuildlessAsyncNotifier<List<ChatRoomEntity>> {
  late final InterviewTopic topic;

  FutureOr<List<ChatRoomEntity>> build(
    InterviewTopic topic,
  );
}

/// See also [UserInterviewRooms].
@ProviderFor(UserInterviewRooms)
const userInterviewRoomsProvider = UserInterviewRoomsFamily();

/// See also [UserInterviewRooms].
class UserInterviewRoomsFamily
    extends Family<AsyncValue<List<ChatRoomEntity>>> {
  /// See also [UserInterviewRooms].
  const UserInterviewRoomsFamily();

  /// See also [UserInterviewRooms].
  UserInterviewRoomsProvider call(
    InterviewTopic topic,
  ) {
    return UserInterviewRoomsProvider(
      topic,
    );
  }

  @override
  UserInterviewRoomsProvider getProviderOverride(
    covariant UserInterviewRoomsProvider provider,
  ) {
    return call(
      provider.topic,
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
  String? get name => r'userInterviewRoomsProvider';
}

/// See also [UserInterviewRooms].
class UserInterviewRoomsProvider extends AsyncNotifierProviderImpl<
    UserInterviewRooms, List<ChatRoomEntity>> {
  /// See also [UserInterviewRooms].
  UserInterviewRoomsProvider(
    InterviewTopic topic,
  ) : this._internal(
          () => UserInterviewRooms()..topic = topic,
          from: userInterviewRoomsProvider,
          name: r'userInterviewRoomsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userInterviewRoomsHash,
          dependencies: UserInterviewRoomsFamily._dependencies,
          allTransitiveDependencies:
              UserInterviewRoomsFamily._allTransitiveDependencies,
          topic: topic,
        );

  UserInterviewRoomsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.topic,
  }) : super.internal();

  final InterviewTopic topic;

  @override
  FutureOr<List<ChatRoomEntity>> runNotifierBuild(
    covariant UserInterviewRooms notifier,
  ) {
    return notifier.build(
      topic,
    );
  }

  @override
  Override overrideWith(UserInterviewRooms Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserInterviewRoomsProvider._internal(
        () => create()..topic = topic,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        topic: topic,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<UserInterviewRooms, List<ChatRoomEntity>>
      createElement() {
    return _UserInterviewRoomsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserInterviewRoomsProvider && other.topic == topic;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topic.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserInterviewRoomsRef on AsyncNotifierProviderRef<List<ChatRoomEntity>> {
  /// The parameter `topic` of this provider.
  InterviewTopic get topic;
}

class _UserInterviewRoomsProviderElement extends AsyncNotifierProviderElement<
    UserInterviewRooms, List<ChatRoomEntity>> with UserInterviewRoomsRef {
  _UserInterviewRoomsProviderElement(super.provider);

  @override
  InterviewTopic get topic => (origin as UserInterviewRoomsProvider).topic;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
