// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wrongAnswersHash() => r'2eb9dfea4fa2caf504886effdeb2f3bf964557ca';

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

abstract class _$WrongAnswers
    extends BuildlessAsyncNotifier<List<WrongAnswerEntity>> {
  late final String topicId;

  FutureOr<List<WrongAnswerEntity>> build(
    String topicId,
  );
}

/// See also [WrongAnswers].
@ProviderFor(WrongAnswers)
const wrongAnswersProvider = WrongAnswersFamily();

/// See also [WrongAnswers].
class WrongAnswersFamily extends Family<AsyncValue<List<WrongAnswerEntity>>> {
  /// See also [WrongAnswers].
  const WrongAnswersFamily();

  /// See also [WrongAnswers].
  WrongAnswersProvider call(
    String topicId,
  ) {
    return WrongAnswersProvider(
      topicId,
    );
  }

  @override
  WrongAnswersProvider getProviderOverride(
    covariant WrongAnswersProvider provider,
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
  String? get name => r'wrongAnswersProvider';
}

/// See also [WrongAnswers].
class WrongAnswersProvider
    extends AsyncNotifierProviderImpl<WrongAnswers, List<WrongAnswerEntity>> {
  /// See also [WrongAnswers].
  WrongAnswersProvider(
    String topicId,
  ) : this._internal(
          () => WrongAnswers()..topicId = topicId,
          from: wrongAnswersProvider,
          name: r'wrongAnswersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wrongAnswersHash,
          dependencies: WrongAnswersFamily._dependencies,
          allTransitiveDependencies:
              WrongAnswersFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  WrongAnswersProvider._internal(
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
  FutureOr<List<WrongAnswerEntity>> runNotifierBuild(
    covariant WrongAnswers notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(WrongAnswers Function() create) {
    return ProviderOverride(
      origin: this,
      override: WrongAnswersProvider._internal(
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
  AsyncNotifierProviderElement<WrongAnswers, List<WrongAnswerEntity>>
      createElement() {
    return _WrongAnswersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WrongAnswersProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WrongAnswersRef on AsyncNotifierProviderRef<List<WrongAnswerEntity>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _WrongAnswersProviderElement
    extends AsyncNotifierProviderElement<WrongAnswers, List<WrongAnswerEntity>>
    with WrongAnswersRef {
  _WrongAnswersProviderElement(super.provider);

  @override
  String get topicId => (origin as WrongAnswersProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
