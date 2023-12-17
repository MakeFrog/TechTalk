// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$interviewRoomsHash() => r'bd4e33c274b839d1f82831d98447b7b4f811eeae';

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

abstract class _$InterviewRooms
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatRoomEntity>> {
  late final String topicId;

  FutureOr<List<ChatRoomEntity>> build(
    String topicId,
  );
}

/// See also [InterviewRooms].
@ProviderFor(InterviewRooms)
const interviewRoomsProvider = InterviewRoomsFamily();

/// See also [InterviewRooms].
class InterviewRoomsFamily extends Family<AsyncValue<List<ChatRoomEntity>>> {
  /// See also [InterviewRooms].
  const InterviewRoomsFamily();

  /// See also [InterviewRooms].
  InterviewRoomsProvider call(
    String topicId,
  ) {
    return InterviewRoomsProvider(
      topicId,
    );
  }

  @override
  InterviewRoomsProvider getProviderOverride(
    covariant InterviewRoomsProvider provider,
  ) {
    return call(
      provider.topicId,
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
  String? get name => r'interviewRoomsProvider';
}

/// See also [InterviewRooms].
class InterviewRoomsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    InterviewRooms, List<ChatRoomEntity>> {
  /// See also [InterviewRooms].
  InterviewRoomsProvider(
    String topicId,
  ) : this._internal(
          () => InterviewRooms()..topicId = topicId,
          from: interviewRoomsProvider,
          name: r'interviewRoomsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$interviewRoomsHash,
          dependencies: InterviewRoomsFamily._dependencies,
          allTransitiveDependencies:
              InterviewRoomsFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  InterviewRoomsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.topicId,
  }) : super.internal();

  final String topicId;

  @override
  FutureOr<List<ChatRoomEntity>> runNotifierBuild(
    covariant InterviewRooms notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(InterviewRooms Function() create) {
    return ProviderOverride(
      origin: this,
      override: InterviewRoomsProvider._internal(
        () => create()..topicId = topicId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        topicId: topicId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<InterviewRooms, List<ChatRoomEntity>>
      createElement() {
    return _InterviewRoomsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InterviewRoomsProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InterviewRoomsRef
    on AutoDisposeAsyncNotifierProviderRef<List<ChatRoomEntity>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _InterviewRoomsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<InterviewRooms,
        List<ChatRoomEntity>> with InterviewRoomsRef {
  _InterviewRoomsProviderElement(super.provider);

  @override
  String get topicId => (origin as InterviewRoomsProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
