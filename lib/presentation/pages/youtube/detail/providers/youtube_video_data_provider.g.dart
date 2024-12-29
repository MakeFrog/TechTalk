// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_video_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeVideoDataHash() => r'a8b69c7d0169db704aeb995cfc86bbe362fa227b';

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

abstract class _$YoutubeVideoData
    extends BuildlessAutoDisposeAsyncNotifier<YouTubeVideoDataEntity> {
  late final String videoId;

  Future<YouTubeVideoDataEntity> build(
    String videoId,
  );
}

/// See also [YoutubeVideoData].
@ProviderFor(YoutubeVideoData)
const youtubeVideoDataProvider = YoutubeVideoDataFamily();

/// See also [YoutubeVideoData].
class YoutubeVideoDataFamily
    extends Family<AsyncValue<YouTubeVideoDataEntity>> {
  /// See also [YoutubeVideoData].
  const YoutubeVideoDataFamily();

  /// See also [YoutubeVideoData].
  YoutubeVideoDataProvider call(
    String videoId,
  ) {
    return YoutubeVideoDataProvider(
      videoId,
    );
  }

  @override
  YoutubeVideoDataProvider getProviderOverride(
    covariant YoutubeVideoDataProvider provider,
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
  String? get name => r'youtubeVideoDataProvider';
}

/// See also [YoutubeVideoData].
class YoutubeVideoDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    YoutubeVideoData, YouTubeVideoDataEntity> {
  /// See also [YoutubeVideoData].
  YoutubeVideoDataProvider(
    String videoId,
  ) : this._internal(
          () => YoutubeVideoData()..videoId = videoId,
          from: youtubeVideoDataProvider,
          name: r'youtubeVideoDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeVideoDataHash,
          dependencies: YoutubeVideoDataFamily._dependencies,
          allTransitiveDependencies:
              YoutubeVideoDataFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  YoutubeVideoDataProvider._internal(
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
  Future<YouTubeVideoDataEntity> runNotifierBuild(
    covariant YoutubeVideoData notifier,
  ) {
    return notifier.build(
      videoId,
    );
  }

  @override
  Override overrideWith(YoutubeVideoData Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeVideoDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<YoutubeVideoData,
      YouTubeVideoDataEntity> createElement() {
    return _YoutubeVideoDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeVideoDataProvider && other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeVideoDataRef
    on AutoDisposeAsyncNotifierProviderRef<YouTubeVideoDataEntity> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _YoutubeVideoDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeVideoData,
        YouTubeVideoDataEntity> with YoutubeVideoDataRef {
  _YoutubeVideoDataProviderElement(super.provider);

  @override
  String get videoId => (origin as YoutubeVideoDataProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
