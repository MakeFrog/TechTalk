// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interview_topics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableUserInterviewTopicsHash() =>
    r'4fe94f9c33f6ddf59f8b242c2aaadae6e44e3d5c';

/// See also [availableUserInterviewTopics].
@ProviderFor(availableUserInterviewTopics)
final availableUserInterviewTopicsProvider =
    AutoDisposeFutureProvider<List<InterviewTopic>>.internal(
  availableUserInterviewTopics,
  name: r'availableUserInterviewTopicsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableUserInterviewTopicsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvailableUserInterviewTopicsRef
    = AutoDisposeFutureProviderRef<List<InterviewTopic>>;
String _$userInterviewTopicsHash() =>
    r'308771032cf461fad1a599033fa6d03d4f4e0891';

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

abstract class _$UserInterviewTopics
    extends BuildlessAsyncNotifier<List<InterviewTopic>> {
  late final bool onlyAvailable;

  FutureOr<List<InterviewTopic>> build({
    bool onlyAvailable = false,
  });
}

/// See also [UserInterviewTopics].
@ProviderFor(UserInterviewTopics)
const userInterviewTopicsProvider = UserInterviewTopicsFamily();

/// See also [UserInterviewTopics].
class UserInterviewTopicsFamily
    extends Family<AsyncValue<List<InterviewTopic>>> {
  /// See also [UserInterviewTopics].
  const UserInterviewTopicsFamily();

  /// See also [UserInterviewTopics].
  UserInterviewTopicsProvider call({
    bool onlyAvailable = false,
  }) {
    return UserInterviewTopicsProvider(
      onlyAvailable: onlyAvailable,
    );
  }

  @override
  UserInterviewTopicsProvider getProviderOverride(
    covariant UserInterviewTopicsProvider provider,
  ) {
    return call(
      onlyAvailable: provider.onlyAvailable,
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
  String? get name => r'userInterviewTopicsProvider';
}

/// See also [UserInterviewTopics].
class UserInterviewTopicsProvider extends AsyncNotifierProviderImpl<
    UserInterviewTopics, List<InterviewTopic>> {
  /// See also [UserInterviewTopics].
  UserInterviewTopicsProvider({
    bool onlyAvailable = false,
  }) : this._internal(
          () => UserInterviewTopics()..onlyAvailable = onlyAvailable,
          from: userInterviewTopicsProvider,
          name: r'userInterviewTopicsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userInterviewTopicsHash,
          dependencies: UserInterviewTopicsFamily._dependencies,
          allTransitiveDependencies:
              UserInterviewTopicsFamily._allTransitiveDependencies,
          onlyAvailable: onlyAvailable,
        );

  UserInterviewTopicsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onlyAvailable,
  }) : super.internal();

  final bool onlyAvailable;

  @override
  FutureOr<List<InterviewTopic>> runNotifierBuild(
    covariant UserInterviewTopics notifier,
  ) {
    return notifier.build(
      onlyAvailable: onlyAvailable,
    );
  }

  @override
  Override overrideWith(UserInterviewTopics Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserInterviewTopicsProvider._internal(
        () => create()..onlyAvailable = onlyAvailable,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onlyAvailable: onlyAvailable,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<UserInterviewTopics, List<InterviewTopic>>
      createElement() {
    return _UserInterviewTopicsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserInterviewTopicsProvider &&
        other.onlyAvailable == onlyAvailable;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onlyAvailable.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserInterviewTopicsRef on AsyncNotifierProviderRef<List<InterviewTopic>> {
  /// The parameter `onlyAvailable` of this provider.
  bool get onlyAvailable;
}

class _UserInterviewTopicsProviderElement extends AsyncNotifierProviderElement<
    UserInterviewTopics, List<InterviewTopic>> with UserInterviewTopicsRef {
  _UserInterviewTopicsProviderElement(super.provider);

  @override
  bool get onlyAvailable =>
      (origin as UserInterviewTopicsProvider).onlyAvailable;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
