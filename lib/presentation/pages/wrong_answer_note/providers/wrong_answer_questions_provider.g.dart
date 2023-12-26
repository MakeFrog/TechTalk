// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answer_questions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wrongAnswerQuestionsHash() =>
    r'318c446038daf5a0ed0db0dc16438b06079110ee';

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

abstract class _$WrongAnswerQuestions
    extends BuildlessAsyncNotifier<List<WrongAnswerNoteEntity>> {
  late final String topicId;

  FutureOr<List<WrongAnswerNoteEntity>> build(
    String topicId,
  );
}

/// See also [WrongAnswerQuestions].
@ProviderFor(WrongAnswerQuestions)
const wrongAnswerQuestionsProvider = WrongAnswerQuestionsFamily();

/// See also [WrongAnswerQuestions].
class WrongAnswerQuestionsFamily
    extends Family<AsyncValue<List<WrongAnswerNoteEntity>>> {
  /// See also [WrongAnswerQuestions].
  const WrongAnswerQuestionsFamily();

  /// See also [WrongAnswerQuestions].
  WrongAnswerQuestionsProvider call(
    String topicId,
  ) {
    return WrongAnswerQuestionsProvider(
      topicId,
    );
  }

  @override
  WrongAnswerQuestionsProvider getProviderOverride(
    covariant WrongAnswerQuestionsProvider provider,
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
  String? get name => r'wrongAnswerQuestionsProvider';
}

/// See also [WrongAnswerQuestions].
class WrongAnswerQuestionsProvider extends AsyncNotifierProviderImpl<
    WrongAnswerQuestions, List<WrongAnswerNoteEntity>> {
  /// See also [WrongAnswerQuestions].
  WrongAnswerQuestionsProvider(
    String topicId,
  ) : this._internal(
          () => WrongAnswerQuestions()..topicId = topicId,
          from: wrongAnswerQuestionsProvider,
          name: r'wrongAnswerQuestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wrongAnswerQuestionsHash,
          dependencies: WrongAnswerQuestionsFamily._dependencies,
          allTransitiveDependencies:
              WrongAnswerQuestionsFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  WrongAnswerQuestionsProvider._internal(
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
  FutureOr<List<WrongAnswerNoteEntity>> runNotifierBuild(
    covariant WrongAnswerQuestions notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(WrongAnswerQuestions Function() create) {
    return ProviderOverride(
      origin: this,
      override: WrongAnswerQuestionsProvider._internal(
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
  AsyncNotifierProviderElement<WrongAnswerQuestions,
      List<WrongAnswerNoteEntity>> createElement() {
    return _WrongAnswerQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WrongAnswerQuestionsProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WrongAnswerQuestionsRef
    on AsyncNotifierProviderRef<List<WrongAnswerNoteEntity>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _WrongAnswerQuestionsProviderElement extends AsyncNotifierProviderElement<
    WrongAnswerQuestions,
    List<WrongAnswerNoteEntity>> with WrongAnswerQuestionsRef {
  _WrongAnswerQuestionsProviderElement(super.provider);

  @override
  String get topicId => (origin as WrongAnswerQuestionsProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member