// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_questions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studyQuestionsHash() => r'26dbd9f92a911b50b519a950c5be910286e56411';

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

abstract class _$StudyQuestions
    extends BuildlessAutoDisposeAsyncNotifier<List<QnaEntity>> {
  late final String topicId;

  FutureOr<List<QnaEntity>> build(
    String topicId,
  );
}

/// See also [StudyQuestions].
@ProviderFor(StudyQuestions)
const studyQuestionsProvider = StudyQuestionsFamily();

/// See also [StudyQuestions].
class StudyQuestionsFamily extends Family<AsyncValue<List<QnaEntity>>> {
  /// See also [StudyQuestions].
  const StudyQuestionsFamily();

  /// See also [StudyQuestions].
  StudyQuestionsProvider call(
    String topicId,
  ) {
    return StudyQuestionsProvider(
      topicId,
    );
  }

  @override
  StudyQuestionsProvider getProviderOverride(
    covariant StudyQuestionsProvider provider,
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
  String? get name => r'studyQuestionsProvider';
}

/// See also [StudyQuestions].
class StudyQuestionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    StudyQuestions, List<QnaEntity>> {
  /// See also [StudyQuestions].
  StudyQuestionsProvider(
    String topicId,
  ) : this._internal(
          () => StudyQuestions()..topicId = topicId,
          from: studyQuestionsProvider,
          name: r'studyQuestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$studyQuestionsHash,
          dependencies: StudyQuestionsFamily._dependencies,
          allTransitiveDependencies:
              StudyQuestionsFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  StudyQuestionsProvider._internal(
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
    covariant StudyQuestions notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(StudyQuestions Function() create) {
    return ProviderOverride(
      origin: this,
      override: StudyQuestionsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<StudyQuestions, List<QnaEntity>>
      createElement() {
    return _StudyQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudyQuestionsProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StudyQuestionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<QnaEntity>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _StudyQuestionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StudyQuestions,
        List<QnaEntity>> with StudyQuestionsRef {
  _StudyQuestionsProviderElement(super.provider);

  @override
  String get topicId => (origin as StudyQuestionsProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
