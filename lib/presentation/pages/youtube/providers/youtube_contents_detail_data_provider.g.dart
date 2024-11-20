// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_contents_detail_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentsDetailDataHash() =>
    r'2e92095ff1a4c6929a2f7678b33aa1984d34ec8b';

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

abstract class _$YoutubeContentsDetailData
    extends BuildlessAutoDisposeAsyncNotifier<YoutubeContentsDetailEntity> {
  late final String videoId;

  FutureOr<YoutubeContentsDetailEntity> build(
    String videoId,
  );
}

/// See also [YoutubeContentsDetailData].
@ProviderFor(YoutubeContentsDetailData)
const youtubeContentsDetailDataProvider = YoutubeContentsDetailDataFamily();

/// See also [YoutubeContentsDetailData].
class YoutubeContentsDetailDataFamily
    extends Family<AsyncValue<YoutubeContentsDetailEntity>> {
  /// See also [YoutubeContentsDetailData].
  const YoutubeContentsDetailDataFamily();

  /// See also [YoutubeContentsDetailData].
  YoutubeContentsDetailDataProvider call(
    String videoId,
  ) {
    return YoutubeContentsDetailDataProvider(
      videoId,
    );
  }

  @override
  YoutubeContentsDetailDataProvider getProviderOverride(
    covariant YoutubeContentsDetailDataProvider provider,
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
  String? get name => r'youtubeContentsDetailDataProvider';
}

/// See also [YoutubeContentsDetailData].
class YoutubeContentsDetailDataProvider
    extends AutoDisposeAsyncNotifierProviderImpl<YoutubeContentsDetailData,
        YoutubeContentsDetailEntity> {
  /// See also [YoutubeContentsDetailData].
  YoutubeContentsDetailDataProvider(
    String videoId,
  ) : this._internal(
          () => YoutubeContentsDetailData()..videoId = videoId,
          from: youtubeContentsDetailDataProvider,
          name: r'youtubeContentsDetailDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeContentsDetailDataHash,
          dependencies: YoutubeContentsDetailDataFamily._dependencies,
          allTransitiveDependencies:
              YoutubeContentsDetailDataFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  YoutubeContentsDetailDataProvider._internal(
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
  FutureOr<YoutubeContentsDetailEntity> runNotifierBuild(
    covariant YoutubeContentsDetailData notifier,
  ) {
    return notifier.build(
      videoId,
    );
  }

  @override
  Override overrideWith(YoutubeContentsDetailData Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeContentsDetailDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<YoutubeContentsDetailData,
      YoutubeContentsDetailEntity> createElement() {
    return _YoutubeContentsDetailDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeContentsDetailDataProvider &&
        other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentsDetailDataRef
    on AutoDisposeAsyncNotifierProviderRef<YoutubeContentsDetailEntity> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _YoutubeContentsDetailDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeContentsDetailData,
        YoutubeContentsDetailEntity> with YoutubeContentsDetailDataRef {
  _YoutubeContentsDetailDataProviderElement(super.provider);

  @override
  String get videoId => (origin as YoutubeContentsDetailDataProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
