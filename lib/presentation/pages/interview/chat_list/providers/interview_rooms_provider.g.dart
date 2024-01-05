// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$interviewRoomsHash() => r'259569c7feef8ca7167f632f6971300799b5fb10';

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
  late final InterviewType type;
  late final String? topicId;

  FutureOr<List<ChatRoomEntity>> build(
    InterviewType type, [
    String? topicId,
  ]);
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
    InterviewType type, [
    String? topicId,
  ]) {
    return InterviewRoomsProvider(
      type,
      topicId,
    );
  }

  @override
  InterviewRoomsProvider getProviderOverride(
    covariant InterviewRoomsProvider provider,
  ) {
    return call(
      provider.type,
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
    InterviewType type, [
    String? topicId,
  ]) : this._internal(
          () => InterviewRooms()
            ..type = type
            ..topicId = topicId,
          from: interviewRoomsProvider,
          name: r'interviewRoomsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$interviewRoomsHash,
          dependencies: InterviewRoomsFamily._dependencies,
          allTransitiveDependencies:
              InterviewRoomsFamily._allTransitiveDependencies,
          type: type,
          topicId: topicId,
        );

  InterviewRoomsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.topicId,
  }) : super.internal();

  final InterviewType type;
  final String? topicId;

  @override
  FutureOr<List<ChatRoomEntity>> runNotifierBuild(
    covariant InterviewRooms notifier,
  ) {
    return notifier.build(
      type,
      topicId,
    );
  }

  @override
  Override overrideWith(InterviewRooms Function() create) {
    return ProviderOverride(
      origin: this,
      override: InterviewRoomsProvider._internal(
        () => create()
          ..type = type
          ..topicId = topicId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
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
    return other is InterviewRoomsProvider &&
        other.type == type &&
        other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InterviewRoomsRef
    on AutoDisposeAsyncNotifierProviderRef<List<ChatRoomEntity>> {
  /// The parameter `type` of this provider.
  InterviewType get type;

  /// The parameter `topicId` of this provider.
  String? get topicId;
}

class _InterviewRoomsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<InterviewRooms,
        List<ChatRoomEntity>> with InterviewRoomsRef {
  _InterviewRoomsProviderElement(super.provider);

  @override
  InterviewType get type => (origin as InterviewRoomsProvider).type;
  @override
  String? get topicId => (origin as InterviewRoomsProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
