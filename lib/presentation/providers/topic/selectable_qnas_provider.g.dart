// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectable_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectableQnasHash() => r'bf4dbeebd22f63ac2f521053a5690cbb78cdcd81';

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

abstract class _$SelectableQnas extends BuildlessAutoDisposeAsyncNotifier<
    List<SelectableQnaEntity<CommonQnaEntity>>> {
  late final String topicId;

  FutureOr<List<SelectableQnaEntity<CommonQnaEntity>>> build(
    String topicId,
  );
}

/// See also [SelectableQnas].
@ProviderFor(SelectableQnas)
const selectableQnasProvider = SelectableQnasFamily();

/// See also [SelectableQnas].
class SelectableQnasFamily
    extends Family<AsyncValue<List<SelectableQnaEntity<CommonQnaEntity>>>> {
  /// See also [SelectableQnas].
  const SelectableQnasFamily();

  /// See also [SelectableQnas].
  SelectableQnasProvider call(
    String topicId,
  ) {
    return SelectableQnasProvider(
      topicId,
    );
  }

  @override
  SelectableQnasProvider getProviderOverride(
    covariant SelectableQnasProvider provider,
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
  String? get name => r'selectableQnasProvider';
}

/// See also [SelectableQnas].
class SelectableQnasProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SelectableQnas, List<SelectableQnaEntity<CommonQnaEntity>>> {
  /// See also [SelectableQnas].
  SelectableQnasProvider(
    String topicId,
  ) : this._internal(
          () => SelectableQnas()..topicId = topicId,
          from: selectableQnasProvider,
          name: r'selectableQnasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectableQnasHash,
          dependencies: SelectableQnasFamily._dependencies,
          allTransitiveDependencies:
              SelectableQnasFamily._allTransitiveDependencies,
          topicId: topicId,
        );

  SelectableQnasProvider._internal(
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
    covariant SelectableQnas notifier,
  ) {
    return notifier.build(
      topicId,
    );
  }

  @override
  Override overrideWith(SelectableQnas Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectableQnasProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SelectableQnas,
      List<SelectableQnaEntity<CommonQnaEntity>>> createElement() {
    return _SelectableQnasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectableQnasProvider && other.topicId == topicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectableQnasRef on AutoDisposeAsyncNotifierProviderRef<
    List<SelectableQnaEntity<CommonQnaEntity>>> {
  /// The parameter `topicId` of this provider.
  String get topicId;
}

class _SelectableQnasProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SelectableQnas,
        List<SelectableQnaEntity<CommonQnaEntity>>> with SelectableQnasRef {
  _SelectableQnasProviderElement(super.provider);

  @override
  String get topicId => (origin as SelectableQnasProvider).topicId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
