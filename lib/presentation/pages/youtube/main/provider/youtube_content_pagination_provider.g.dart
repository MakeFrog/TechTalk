// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_content_pagination_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentPaginationHash() =>
    r'632fdea6589c85ed709abac7a52bd42f28e06df6';

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

/// See also [youtubeContentPagination].
@ProviderFor(youtubeContentPagination)
const youtubeContentPaginationProvider = YoutubeContentPaginationFamily();

/// See also [youtubeContentPagination].
class YoutubeContentPaginationFamily extends Family<
    PagingController<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeContentOverviewEntity>> {
  /// See also [youtubeContentPagination].
  const YoutubeContentPaginationFamily();

  /// See also [youtubeContentPagination].
  YoutubeContentPaginationProvider call({
    required YoutubeContentCategory category,
  }) {
    return YoutubeContentPaginationProvider(
      category: category,
    );
  }

  @override
  YoutubeContentPaginationProvider getProviderOverride(
    covariant YoutubeContentPaginationProvider provider,
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
  String? get name => r'youtubeContentPaginationProvider';
}

/// See also [youtubeContentPagination].
class YoutubeContentPaginationProvider extends Provider<
    PagingController<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeContentOverviewEntity>> {
  /// See also [youtubeContentPagination].
  YoutubeContentPaginationProvider({
    required YoutubeContentCategory category,
  }) : this._internal(
          (ref) => youtubeContentPagination(
            ref as YoutubeContentPaginationRef,
            category: category,
          ),
          from: youtubeContentPaginationProvider,
          name: r'youtubeContentPaginationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeContentPaginationHash,
          dependencies: YoutubeContentPaginationFamily._dependencies,
          allTransitiveDependencies:
              YoutubeContentPaginationFamily._allTransitiveDependencies,
          category: category,
        );

  YoutubeContentPaginationProvider._internal(
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
    PagingController<DocumentSnapshot<YoutubeMainModel>?,
                YoutubeContentOverviewEntity>
            Function(YoutubeContentPaginationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YoutubeContentPaginationProvider._internal(
        (ref) => create(ref as YoutubeContentPaginationRef),
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
  ProviderElement<
      PagingController<DocumentSnapshot<YoutubeMainModel>?,
          YoutubeContentOverviewEntity>> createElement() {
    return _YoutubeContentPaginationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeContentPaginationProvider &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentPaginationRef on ProviderRef<
    PagingController<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeContentOverviewEntity>> {
  /// The parameter `category` of this provider.
  YoutubeContentCategory get category;
}

class _YoutubeContentPaginationProviderElement extends ProviderElement<
    PagingController<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeContentOverviewEntity>> with YoutubeContentPaginationRef {
  _YoutubeContentPaginationProviderElement(super.provider);

  @override
  YoutubeContentCategory get category =>
      (origin as YoutubeContentPaginationProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
