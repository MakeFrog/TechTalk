// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_progress_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$interviewProgressStateHash() =>
    r'040860934703453d2e04e58a8eb5b64856539080';

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

abstract class _$InterviewProgressState
    extends BuildlessAutoDisposeNotifier<InterviewProgress> {
  late final ChatRoomEntity room;

  InterviewProgress build(
    ChatRoomEntity room,
  );
}

/// See also [InterviewProgressState].
@ProviderFor(InterviewProgressState)
const interviewProgressStateProvider = InterviewProgressStateFamily();

/// See also [InterviewProgressState].
class InterviewProgressStateFamily extends Family<InterviewProgress> {
  /// See also [InterviewProgressState].
  const InterviewProgressStateFamily();

  /// See also [InterviewProgressState].
  InterviewProgressStateProvider call(
    ChatRoomEntity room,
  ) {
    return InterviewProgressStateProvider(
      room,
    );
  }

  @override
  InterviewProgressStateProvider getProviderOverride(
    covariant InterviewProgressStateProvider provider,
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
  String? get name => r'interviewProgressStateProvider';
}

/// See also [InterviewProgressState].
class InterviewProgressStateProvider extends AutoDisposeNotifierProviderImpl<
    InterviewProgressState, InterviewProgress> {
  /// See also [InterviewProgressState].
  InterviewProgressStateProvider(
    ChatRoomEntity room,
  ) : this._internal(
          () => InterviewProgressState()..room = room,
          from: interviewProgressStateProvider,
          name: r'interviewProgressStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$interviewProgressStateHash,
          dependencies: InterviewProgressStateFamily._dependencies,
          allTransitiveDependencies:
              InterviewProgressStateFamily._allTransitiveDependencies,
          room: room,
        );

  InterviewProgressStateProvider._internal(
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
  InterviewProgress runNotifierBuild(
    covariant InterviewProgressState notifier,
  ) {
    return notifier.build(
      room,
    );
  }

  @override
  Override overrideWith(InterviewProgressState Function() create) {
    return ProviderOverride(
      origin: this,
      override: InterviewProgressStateProvider._internal(
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
  AutoDisposeNotifierProviderElement<InterviewProgressState, InterviewProgress>
      createElement() {
    return _InterviewProgressStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InterviewProgressStateProvider && other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InterviewProgressStateRef
    on AutoDisposeNotifierProviderRef<InterviewProgress> {
  /// The parameter `room` of this provider.
  ChatRoomEntity get room;
}

class _InterviewProgressStateProviderElement
    extends AutoDisposeNotifierProviderElement<InterviewProgressState,
        InterviewProgress> with InterviewProgressStateRef {
  _InterviewProgressStateProviderElement(super.provider);

  @override
  ChatRoomEntity get room => (origin as InterviewProgressStateProvider).room;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
