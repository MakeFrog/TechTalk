// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_contents_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentsDetailHash() =>
    r'ddf5f60a5e2826ec8bcde605e6697b50be84e2dd';

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

abstract class _$YoutubeContentsDetail
    extends BuildlessAutoDisposeAsyncNotifier<YoutubeContentsDetailEntity> {
  late final String videoId;

  FutureOr<YoutubeContentsDetailEntity> build(
    String videoId,
  );
}

/// See also [YoutubeContentsDetail].
@ProviderFor(YoutubeContentsDetail)
const youtubeContentsDetailProvider = YoutubeContentsDetailFamily();

/// See also [YoutubeContentsDetail].
class YoutubeContentsDetailFamily
    extends Family<AsyncValue<YoutubeContentsDetailEntity>> {
  /// See also [YoutubeContentsDetail].
  const YoutubeContentsDetailFamily();

  /// See also [YoutubeContentsDetail].
  YoutubeContentsDetailProvider call(
    String videoId,
  ) {
    return YoutubeContentsDetailProvider(
      videoId,
    );
  }

  @override
  YoutubeContentsDetailProvider getProviderOverride(
    covariant YoutubeContentsDetailProvider provider,
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
  String? get name => r'youtubeContentsDetailProvider';
}

/// See also [YoutubeContentsDetail].
class YoutubeContentsDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<YoutubeContentsDetail,
        YoutubeContentsDetailEntity> {
  /// See also [YoutubeContentsDetail].
  YoutubeContentsDetailProvider(
    String videoId,
  ) : this._internal(
          () => YoutubeContentsDetail()..videoId = videoId,
          from: youtubeContentsDetailProvider,
          name: r'youtubeContentsDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeContentsDetailHash,
          dependencies: YoutubeContentsDetailFamily._dependencies,
          allTransitiveDependencies:
              YoutubeContentsDetailFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  YoutubeContentsDetailProvider._internal(
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
    covariant YoutubeContentsDetail notifier,
  ) {
    return notifier.build(
      videoId,
    );
  }

  @override
  Override overrideWith(YoutubeContentsDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeContentsDetailProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<YoutubeContentsDetail,
      YoutubeContentsDetailEntity> createElement() {
    return _YoutubeContentsDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeContentsDetailProvider && other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentsDetailRef
    on AutoDisposeAsyncNotifierProviderRef<YoutubeContentsDetailEntity> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _YoutubeContentsDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeContentsDetail,
        YoutubeContentsDetailEntity> with YoutubeContentsDetailRef {
  _YoutubeContentsDetailProviderElement(super.provider);

  @override
  String get videoId => (origin as YoutubeContentsDetailProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
