// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectable_common_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectableCommonQnasHash() =>
    r'6b0942f9c4be6edc0ab3727e96bf35e98d523038';

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

abstract class _$SelectableCommonQnas extends BuildlessAutoDisposeAsyncNotifier<
    List<SelectableQnaEntity<CommonQnaEntity>>> {
  late final String topicId;

  FutureOr<List<SelectableQnaEntity<CommonQnaEntity>>> build(
    String topicId,
  );
}

/// See also [SelectableCommonQnas].
@ProviderFor(SelectableCommonQnas)
const selectableCommonQnasProvider = SelectableCommonQnasFamily();

/// See also [SelectableCommonQnas].
class SelectableCommonQnasFamily
    extends Family<AsyncValue<List<SelectableQnaEntity<CommonQnaEntity>>>> {
  /// See also [SelectableCommonQnas].
  const SelectableCommonQnasFamily();

  /// See also [SelectableCommonQnas].
  SelectableCommonQnasProvider call(
    String topicId,
  ) {
    return SelectableCommonQnasProvider(
      topicId,
    );
  }

  @override
  SelectableCommonQnasProvider getProviderOverride(
    covariant SelectableCommonQnasProvider provider,
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
  String? get name => r'selectableCommonQnasProvider';
}

/// See also [SelectableCommonQnas].
class SelectableCommonQnasProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SelectableCommonQnas, List<SelectableQnaEntity<CommonQnaEntity>>> {
  /// See also [SelectableCommonQnas].
  SelectableCommonQnasProvider(
    String topicId,
  ) : this._internal(
          () => SelectableCommonQnas()..topicId = topicId,
          from: selectableCommonQnasProvider,
          name: r'selectableCommonQnasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectableCommonQnasHash,
          dependencies: SelectableCommonQnasFamily._dependencies,
          allTransitiveDependencies:
              SelectableCommonQnasFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  SelectableCommonQnasProvider._internal(
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
  FutureOr<List<SelectableQnaEntity<CommonQnaEntity>>> runNotifierBuild(
    covariant SelectableCommonQnas notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(SelectableCommonQnas Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectableCommonQnasProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SelectableCommonQnas,
      List<SelectableQnaEntity<CommonQnaEntity>>> createElement() {
    return _SelectableCommonQnasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectableCommonQnasProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectableCommonQnasRef on AutoDisposeAsyncNotifierProviderRef<
    List<SelectableQnaEntity<CommonQnaEntity>>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _SelectableCommonQnasProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SelectableCommonQnas,
        List<SelectableQnaEntity<CommonQnaEntity>>>
    with SelectableCommonQnasRef {
  _SelectableCommonQnasProviderElement(super.provider);

  @override
  String get topicId => (origin as SelectableCommonQnasProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
