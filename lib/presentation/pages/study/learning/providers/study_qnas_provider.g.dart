// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studyQnasHash() => r'74c8ed4640bcbff51e51b30129be15986ceffe2b';

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

abstract class _$StudyQnas
    extends BuildlessAutoDisposeAsyncNotifier<List<QnaEntity>> {
  late final String topicId;

  FutureOr<List<QnaEntity>> build(
    String topicId,
  );
}

/// See also [StudyQnas].
@ProviderFor(StudyQnas)
const studyQnasProvider = StudyQnasFamily();

/// See also [StudyQnas].
class StudyQnasFamily extends Family<AsyncValue<List<QnaEntity>>> {
  /// See also [StudyQnas].
  const StudyQnasFamily();

  /// See also [StudyQnas].
  StudyQnasProvider call(
    String topicId,
  ) {
    return StudyQnasProvider(
      topicId,
    );
  }

  @override
  StudyQnasProvider getProviderOverride(
    covariant StudyQnasProvider provider,
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
  String? get name => r'studyQnasProvider';
}

/// See also [StudyQnas].
class StudyQnasProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StudyQnas, List<QnaEntity>> {
  /// See also [StudyQnas].
  StudyQnasProvider(
    String topicId,
  ) : this._internal(
          () => StudyQnas()..topicId = topicId,
          from: studyQnasProvider,
          name: r'studyQnasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$studyQnasHash,
          dependencies: StudyQnasFamily._dependencies,
          allTransitiveDependencies: StudyQnasFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  StudyQnasProvider._internal(
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
  FutureOr<List<QnaEntity>> runNotifierBuild(
    covariant StudyQnas notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(StudyQnas Function() create) {
    return ProviderOverride(
      origin: this,
      override: StudyQnasProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<StudyQnas, List<QnaEntity>>
      createElement() {
    return _StudyQnasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudyQnasProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StudyQnasRef on AutoDisposeAsyncNotifierProviderRef<List<QnaEntity>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _StudyQnasProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StudyQnas, List<QnaEntity>>
    with StudyQnasRef {
  _StudyQnasProviderElement(super.provider);

  @override
  String get topicId => (origin as StudyQnasProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
