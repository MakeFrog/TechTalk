// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_proficiency_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createdProficiencyQnasHash() =>
    r'523631999a3ebd11c61a1019129f6b7129511cd5';

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

abstract class _$CreatedProficiencyQnas
    extends BuildlessAutoDisposeAsyncNotifier<List<ProficiencyQnaEntity>> {
  late final ProficiencyInterviewFlowParam useCaseParam;

  Future<List<ProficiencyQnaEntity>> build(
    ProficiencyInterviewFlowParam useCaseParam,
  );
}

/// See also [CreatedProficiencyQnas].
@ProviderFor(CreatedProficiencyQnas)
const createdProficiencyQnasProvider = CreatedProficiencyQnasFamily();

/// See also [CreatedProficiencyQnas].
class CreatedProficiencyQnasFamily
    extends Family<AsyncValue<List<ProficiencyQnaEntity>>> {
  /// See also [CreatedProficiencyQnas].
  const CreatedProficiencyQnasFamily();

  /// See also [CreatedProficiencyQnas].
  CreatedProficiencyQnasProvider call(
    ProficiencyInterviewFlowParam useCaseParam,
  ) {
    return CreatedProficiencyQnasProvider(
      useCaseParam,
    );
  }

  @override
  CreatedProficiencyQnasProvider getProviderOverride(
    covariant CreatedProficiencyQnasProvider provider,
  ) {
    return call(
      provider.useCaseParam,
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
  String? get name => r'createdProficiencyQnasProvider';
}

/// See also [CreatedProficiencyQnas].
class CreatedProficiencyQnasProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CreatedProficiencyQnas,
        List<ProficiencyQnaEntity>> {
  /// See also [CreatedProficiencyQnas].
  CreatedProficiencyQnasProvider(
    ProficiencyInterviewFlowParam useCaseParam,
  ) : this._internal(
          () => CreatedProficiencyQnas()..useCaseParam = useCaseParam,
          from: createdProficiencyQnasProvider,
          name: r'createdProficiencyQnasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createdProficiencyQnasHash,
          dependencies: CreatedProficiencyQnasFamily._dependencies,
          allTransitiveDependencies:
              CreatedProficiencyQnasFamily._allTransitiveDependencies,
          useCaseParam: useCaseParam,
        );

  CreatedProficiencyQnasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.useCaseParam,
  }) : super.internal();

  final ProficiencyInterviewFlowParam useCaseParam;

  @override
  Future<List<ProficiencyQnaEntity>> runNotifierBuild(
    covariant CreatedProficiencyQnas notifier,
  ) {
    return notifier.build(
      useCaseParam,
    );
  }

  @override
  Override overrideWith(CreatedProficiencyQnas Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreatedProficiencyQnasProvider._internal(
        () => create()..useCaseParam = useCaseParam,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        useCaseParam: useCaseParam,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CreatedProficiencyQnas,
      List<ProficiencyQnaEntity>> createElement() {
    return _CreatedProficiencyQnasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreatedProficiencyQnasProvider &&
        other.useCaseParam == useCaseParam;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, useCaseParam.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreatedProficiencyQnasRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProficiencyQnaEntity>> {
  /// The parameter `useCaseParam` of this provider.
  ProficiencyInterviewFlowParam get useCaseParam;
}

class _CreatedProficiencyQnasProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CreatedProficiencyQnas,
        List<ProficiencyQnaEntity>> with CreatedProficiencyQnasRef {
  _CreatedProficiencyQnasProviderElement(super.provider);

  @override
  ProficiencyInterviewFlowParam get useCaseParam =>
      (origin as CreatedProficiencyQnasProvider).useCaseParam;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
