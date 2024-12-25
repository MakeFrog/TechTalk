// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_contents_overviews_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentsOverviewsHash() =>
    r'c52eb0919487578a018ded8aa2ff3bdd90920a06';

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
    required YoutubeContentCategory category,
  }) {
    return YoutubeContentsOverviewsProvider(
      category: category,
    );
  }

  @override
  YoutubeContentsOverviewsProvider getProviderOverride(
    covariant YoutubeContentsOverviewsProvider provider,
  ) {
    return call(
      category: provider.category,
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
    required YoutubeContentCategory category,
  }) : this._internal(
          (ref) => youtubeContentsOverviews(
            ref as YoutubeContentsOverviewsRef,
            category: category,
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
          category: category,
        );

  YoutubeContentsOverviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final YoutubeContentCategory category;

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
        category: category,
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
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentsOverviewsRef on AutoDisposeProviderRef<
    Raw<
        PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
            YoutubeContentOverviewEntity>>> {
  /// The parameter `category` of this provider.
  YoutubeContentCategory get category;
}

class _YoutubeContentsOverviewsProviderElement
    extends AutoDisposeProviderElement<
        Raw<
            PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
                YoutubeContentOverviewEntity>>>
    with YoutubeContentsOverviewsRef {
  _YoutubeContentsOverviewsProviderElement(super.provider);

  @override
  YoutubeContentCategory get category =>
      (origin as YoutubeContentsOverviewsProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
