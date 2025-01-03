// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_contents_detail_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentsDetailQnasHash() =>
    r'02286b4dfa2c606661171535692bfe1785cd9e2d';

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

abstract class _$YoutubeContentsDetailQnas
    extends BuildlessAutoDisposeAsyncNotifier<List<YoutubeQnaEntity>> {
  late final String videoId;

  Future<List<YoutubeQnaEntity>> build(
    String videoId,
  );
}

/// See also [YoutubeContentsDetailQnas].
@ProviderFor(YoutubeContentsDetailQnas)
const youtubeContentsDetailQnasProvider = YoutubeContentsDetailQnasFamily();

/// See also [YoutubeContentsDetailQnas].
class YoutubeContentsDetailQnasFamily
    extends Family<AsyncValue<List<YoutubeQnaEntity>>> {
  /// See also [YoutubeContentsDetailQnas].
  const YoutubeContentsDetailQnasFamily();

  /// See also [YoutubeContentsDetailQnas].
  YoutubeContentsDetailQnasProvider call(
    String videoId,
  ) {
    return YoutubeContentsDetailQnasProvider(
      videoId,
    );
  }

  @override
  YoutubeContentsDetailQnasProvider getProviderOverride(
    covariant YoutubeContentsDetailQnasProvider provider,
  ) {
    return call(
      provider.videoId,
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
  String? get name => r'youtubeContentsDetailQnasProvider';
}

/// See also [YoutubeContentsDetailQnas].
class YoutubeContentsDetailQnasProvider
    extends AutoDisposeAsyncNotifierProviderImpl<YoutubeContentsDetailQnas,
        List<YoutubeQnaEntity>> {
  /// See also [YoutubeContentsDetailQnas].
  YoutubeContentsDetailQnasProvider(
    String videoId,
  ) : this._internal(
          () => YoutubeContentsDetailQnas()..videoId = videoId,
          from: youtubeContentsDetailQnasProvider,
          name: r'youtubeContentsDetailQnasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeContentsDetailQnasHash,
          dependencies: YoutubeContentsDetailQnasFamily._dependencies,
          allTransitiveDependencies:
              YoutubeContentsDetailQnasFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  YoutubeContentsDetailQnasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.videoId,
  }) : super.internal();

  final String videoId;

  @override
  Future<List<YoutubeQnaEntity>> runNotifierBuild(
    covariant YoutubeContentsDetailQnas notifier,
  ) {
    return notifier.build(
      videoId,
    );
  }

  @override
  Override overrideWith(YoutubeContentsDetailQnas Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeContentsDetailQnasProvider._internal(
        () => create()..videoId = videoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        videoId: videoId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<YoutubeContentsDetailQnas,
      List<YoutubeQnaEntity>> createElement() {
    return _YoutubeContentsDetailQnasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeContentsDetailQnasProvider &&
        other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentsDetailQnasRef
    on AutoDisposeAsyncNotifierProviderRef<List<YoutubeQnaEntity>> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _YoutubeContentsDetailQnasProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeContentsDetailQnas,
        List<YoutubeQnaEntity>> with YoutubeContentsDetailQnasRef {
  _YoutubeContentsDetailQnasProviderElement(super.provider);

  @override
  String get videoId => (origin as YoutubeContentsDetailQnasProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
