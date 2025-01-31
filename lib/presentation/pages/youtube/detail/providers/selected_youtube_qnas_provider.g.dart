// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_youtube_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedYoutubeQnasHash() =>
    r'399e666882510e45fd984ea6a1d541518456cf70';

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

abstract class _$SelectedYoutubeQnas
    extends BuildlessAutoDisposeNotifier<List<YoutubeQnaEntity>> {
  late final String contentId;
  late final List<YoutubeQnaEntity>? passedQnas;

  List<YoutubeQnaEntity> build(
    String contentId, {
    required List<YoutubeQnaEntity>? passedQnas,
  });
}

/// See also [SelectedYoutubeQnas].
@ProviderFor(SelectedYoutubeQnas)
const selectedYoutubeQnasProvider = SelectedYoutubeQnasFamily();

/// See also [SelectedYoutubeQnas].
class SelectedYoutubeQnasFamily extends Family<List<YoutubeQnaEntity>> {
  /// See also [SelectedYoutubeQnas].
  const SelectedYoutubeQnasFamily();

  /// See also [SelectedYoutubeQnas].
  SelectedYoutubeQnasProvider call(
    String contentId, {
    required List<YoutubeQnaEntity>? passedQnas,
  }) {
    return SelectedYoutubeQnasProvider(
      contentId,
      passedQnas: passedQnas,
    );
  }

  @override
  SelectedYoutubeQnasProvider getProviderOverride(
    covariant SelectedYoutubeQnasProvider provider,
  ) {
    return call(
      provider.contentId,
      passedQnas: provider.passedQnas,
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
  String? get name => r'selectedYoutubeQnasProvider';
}

/// See also [SelectedYoutubeQnas].
class SelectedYoutubeQnasProvider extends AutoDisposeNotifierProviderImpl<
    SelectedYoutubeQnas, List<YoutubeQnaEntity>> {
  /// See also [SelectedYoutubeQnas].
  SelectedYoutubeQnasProvider(
    String contentId, {
    required List<YoutubeQnaEntity>? passedQnas,
  }) : this._internal(
          () => SelectedYoutubeQnas()
            ..contentId = contentId
            ..passedQnas = passedQnas,
          from: selectedYoutubeQnasProvider,
          name: r'selectedYoutubeQnasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedYoutubeQnasHash,
          dependencies: SelectedYoutubeQnasFamily._dependencies,
          allTransitiveDependencies:
              SelectedYoutubeQnasFamily._allTransitiveDependencies,
          contentId: contentId,
          passedQnas: passedQnas,
        );

  SelectedYoutubeQnasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contentId,
    required this.passedQnas,
  }) : super.internal();

  final String contentId;
  final List<YoutubeQnaEntity>? passedQnas;

  @override
  List<YoutubeQnaEntity> runNotifierBuild(
    covariant SelectedYoutubeQnas notifier,
  ) {
    return notifier.build(
      contentId,
      passedQnas: passedQnas,
    );
  }

  @override
  Override overrideWith(SelectedYoutubeQnas Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedYoutubeQnasProvider._internal(
        () => create()
          ..contentId = contentId
          ..passedQnas = passedQnas,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contentId: contentId,
        passedQnas: passedQnas,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedYoutubeQnas,
      List<YoutubeQnaEntity>> createElement() {
    return _SelectedYoutubeQnasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedYoutubeQnasProvider &&
        other.contentId == contentId &&
        other.passedQnas == passedQnas;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);
    hash = _SystemHash.combine(hash, passedQnas.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedYoutubeQnasRef
    on AutoDisposeNotifierProviderRef<List<YoutubeQnaEntity>> {
  /// The parameter `contentId` of this provider.
  String get contentId;

  /// The parameter `passedQnas` of this provider.
  List<YoutubeQnaEntity>? get passedQnas;
}

class _SelectedYoutubeQnasProviderElement
    extends AutoDisposeNotifierProviderElement<SelectedYoutubeQnas,
        List<YoutubeQnaEntity>> with SelectedYoutubeQnasRef {
  _SelectedYoutubeQnasProviderElement(super.provider);

  @override
  String get contentId => (origin as SelectedYoutubeQnasProvider).contentId;
  @override
  List<YoutubeQnaEntity>? get passedQnas =>
      (origin as SelectedYoutubeQnasProvider).passedQnas;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
