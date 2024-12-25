// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_contents_overviews_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentsOverviewsHash() =>
    r'563399e8f6cfac0650deb9bf38849caed8852f4c';

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

/// See also [youtubeContentsOverviews].
@ProviderFor(youtubeContentsOverviews)
const youtubeContentsOverviewsProvider = YoutubeContentsOverviewsFamily();

/// See also [youtubeContentsOverviews].
class YoutubeContentsOverviewsFamily extends Family<
    Raw<
        PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
            YoutubeContentOverviewEntity>>> {
  /// See also [youtubeContentsOverviews].
  const YoutubeContentsOverviewsFamily();

  /// See also [youtubeContentsOverviews].
  YoutubeContentsOverviewsProvider call({
    required YoutubeContentCategory filterArg,
  }) {
    return YoutubeContentsOverviewsProvider(
      filterArg: filterArg,
    );
  }

  @override
  YoutubeContentsOverviewsProvider getProviderOverride(
    covariant YoutubeContentsOverviewsProvider provider,
  ) {
    return call(
      filterArg: provider.filterArg,
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
  String? get name => r'youtubeContentsOverviewsProvider';
}

/// See also [youtubeContentsOverviews].
class YoutubeContentsOverviewsProvider extends AutoDisposeProvider<
    Raw<
        PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
            YoutubeContentOverviewEntity>>> {
  /// See also [youtubeContentsOverviews].
  YoutubeContentsOverviewsProvider({
    required YoutubeContentCategory filterArg,
  }) : this._internal(
          (ref) => youtubeContentsOverviews(
            ref as YoutubeContentsOverviewsRef,
            filterArg: filterArg,
          ),
          from: youtubeContentsOverviewsProvider,
          name: r'youtubeContentsOverviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeContentsOverviewsHash,
          dependencies: YoutubeContentsOverviewsFamily._dependencies,
          allTransitiveDependencies:
              YoutubeContentsOverviewsFamily._allTransitiveDependencies,
          filterArg: filterArg,
        );

  YoutubeContentsOverviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filterArg,
  }) : super.internal();

  final YoutubeContentCategory filterArg;

  @override
  Override overrideWith(
    Raw<
                PagingController<
                    DocumentSnapshot<YoutubeContentsOverviewModel>?,
                    YoutubeContentOverviewEntity>>
            Function(YoutubeContentsOverviewsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YoutubeContentsOverviewsProvider._internal(
        (ref) => create(ref as YoutubeContentsOverviewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filterArg: filterArg,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<
      Raw<
          PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
              YoutubeContentOverviewEntity>>> createElement() {
    return _YoutubeContentsOverviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeContentsOverviewsProvider &&
        other.filterArg == filterArg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filterArg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentsOverviewsRef on AutoDisposeProviderRef<
    Raw<
        PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
            YoutubeContentOverviewEntity>>> {
  /// The parameter `filterArg` of this provider.
  YoutubeContentCategory get filterArg;
}

class _YoutubeContentsOverviewsProviderElement
    extends AutoDisposeProviderElement<
        Raw<
            PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
                YoutubeContentOverviewEntity>>>
    with YoutubeContentsOverviewsRef {
  _YoutubeContentsOverviewsProviderElement(super.provider);

  @override
  YoutubeContentCategory get filterArg =>
      (origin as YoutubeContentsOverviewsProvider).filterArg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
