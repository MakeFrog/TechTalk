// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_youtube_videos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$relatedYoutubeVideoHash() =>
    r'fbc2daf6d30a261b8b5c39d98c3241969bdd13ea';

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

abstract class _$RelatedYoutubeVideo
    extends BuildlessAutoDisposeAsyncNotifier<List<RelatedVideoEntity>> {
  late final String contentId;

  FutureOr<List<RelatedVideoEntity>> build(
    String contentId,
  );
}

/// See also [RelatedYoutubeVideo].
@ProviderFor(RelatedYoutubeVideo)
const relatedYoutubeVideoProvider = RelatedYoutubeVideoFamily();

/// See also [RelatedYoutubeVideo].
class RelatedYoutubeVideoFamily
    extends Family<AsyncValue<List<RelatedVideoEntity>>> {
  /// See also [RelatedYoutubeVideo].
  const RelatedYoutubeVideoFamily();

  /// See also [RelatedYoutubeVideo].
  RelatedYoutubeVideoProvider call(
    String contentId,
  ) {
    return RelatedYoutubeVideoProvider(
      contentId,
    );
  }

  @override
  RelatedYoutubeVideoProvider getProviderOverride(
    covariant RelatedYoutubeVideoProvider provider,
  ) {
    return call(
      provider.contentId,
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
  String? get name => r'relatedYoutubeVideoProvider';
}

/// See also [RelatedYoutubeVideo].
class RelatedYoutubeVideoProvider extends AutoDisposeAsyncNotifierProviderImpl<
    RelatedYoutubeVideo, List<RelatedVideoEntity>> {
  /// See also [RelatedYoutubeVideo].
  RelatedYoutubeVideoProvider(
    String contentId,
  ) : this._internal(
          () => RelatedYoutubeVideo()..contentId = contentId,
          from: relatedYoutubeVideoProvider,
          name: r'relatedYoutubeVideoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$relatedYoutubeVideoHash,
          dependencies: RelatedYoutubeVideoFamily._dependencies,
          allTransitiveDependencies:
              RelatedYoutubeVideoFamily._allTransitiveDependencies,
          contentId: contentId,
        );

  RelatedYoutubeVideoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contentId,
  }) : super.internal();

  final String contentId;

  @override
  FutureOr<List<RelatedVideoEntity>> runNotifierBuild(
    covariant RelatedYoutubeVideo notifier,
  ) {
    return notifier.build(
      contentId,
    );
  }

  @override
  Override overrideWith(RelatedYoutubeVideo Function() create) {
    return ProviderOverride(
      origin: this,
      override: RelatedYoutubeVideoProvider._internal(
        () => create()..contentId = contentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contentId: contentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RelatedYoutubeVideo,
      List<RelatedVideoEntity>> createElement() {
    return _RelatedYoutubeVideoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RelatedYoutubeVideoProvider && other.contentId == contentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RelatedYoutubeVideoRef
    on AutoDisposeAsyncNotifierProviderRef<List<RelatedVideoEntity>> {
  /// The parameter `contentId` of this provider.
  String get contentId;
}

class _RelatedYoutubeVideoProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RelatedYoutubeVideo,
        List<RelatedVideoEntity>> with RelatedYoutubeVideoRef {
  _RelatedYoutubeVideoProviderElement(super.provider);

  @override
  String get contentId => (origin as RelatedYoutubeVideoProvider).contentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
