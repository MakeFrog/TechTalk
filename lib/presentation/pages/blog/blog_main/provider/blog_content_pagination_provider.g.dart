// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_content_pagination_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$blogContentPaginationHash() =>
    r'1efa449fb349a96f473ac89a55de511b7126d48b';

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

/// See also [blogContentPagination].
@ProviderFor(blogContentPagination)
const blogContentPaginationProvider = BlogContentPaginationFamily();

/// See also [blogContentPagination].
class BlogContentPaginationFamily extends Family<
    PagingController<DocumentSnapshot<BlogShellEntity>?, BlogShellEntity>> {
  /// See also [blogContentPagination].
  const BlogContentPaginationFamily();

  /// See also [blogContentPagination].
  BlogContentPaginationProvider call({
    required ContentFilterCategory category,
  }) {
    return BlogContentPaginationProvider(
      category: category,
    );
  }

  @override
  BlogContentPaginationProvider getProviderOverride(
    covariant BlogContentPaginationProvider provider,
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
  String? get name => r'blogContentPaginationProvider';
}

/// See also [blogContentPagination].
class BlogContentPaginationProvider extends Provider<
    PagingController<DocumentSnapshot<BlogShellEntity>?, BlogShellEntity>> {
  /// See also [blogContentPagination].
  BlogContentPaginationProvider({
    required ContentFilterCategory category,
  }) : this._internal(
          (ref) => blogContentPagination(
            ref as BlogContentPaginationRef,
            category: category,
          ),
          from: blogContentPaginationProvider,
          name: r'blogContentPaginationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$blogContentPaginationHash,
          dependencies: BlogContentPaginationFamily._dependencies,
          allTransitiveDependencies:
              BlogContentPaginationFamily._allTransitiveDependencies,
          category: category,
        );

  BlogContentPaginationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final ContentFilterCategory category;

  @override
  Override overrideWith(
    PagingController<DocumentSnapshot<BlogShellEntity>?, BlogShellEntity>
            Function(BlogContentPaginationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BlogContentPaginationProvider._internal(
        (ref) => create(ref as BlogContentPaginationRef),
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
          PagingController<DocumentSnapshot<BlogShellEntity>?, BlogShellEntity>>
      createElement() {
    return _BlogContentPaginationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BlogContentPaginationProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BlogContentPaginationRef on ProviderRef<
    PagingController<DocumentSnapshot<BlogShellEntity>?, BlogShellEntity>> {
  /// The parameter `category` of this provider.
  ContentFilterCategory get category;
}

class _BlogContentPaginationProviderElement extends ProviderElement<
        PagingController<DocumentSnapshot<BlogShellEntity>?, BlogShellEntity>>
    with BlogContentPaginationRef {
  _BlogContentPaginationProviderElement(super.provider);

  @override
  ContentFilterCategory get category =>
      (origin as BlogContentPaginationProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
