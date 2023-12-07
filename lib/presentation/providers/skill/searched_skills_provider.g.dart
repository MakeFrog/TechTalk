// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_skills_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchedSkillsHash() => r'aafda33475adab7200910b820547a8c41d1a2ca6';

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

/// See also [searchedSkills].
@ProviderFor(searchedSkills)
const searchedSkillsProvider = SearchedSkillsFamily();

/// See also [searchedSkills].
class SearchedSkillsFamily extends Family<AsyncValue<List<SkillEntity>>> {
  /// See also [searchedSkills].
  const SearchedSkillsFamily();

  /// See also [searchedSkills].
  SearchedSkillsProvider call({
    String? keyword,
  }) {
    return SearchedSkillsProvider(
      keyword: keyword,
    );
  }

  @override
  SearchedSkillsProvider getProviderOverride(
    covariant SearchedSkillsProvider provider,
  ) {
    return call(
      keyword: provider.keyword,
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
  String? get name => r'searchedSkillsProvider';
}

/// See also [searchedSkills].
class SearchedSkillsProvider
    extends AutoDisposeFutureProvider<List<SkillEntity>> {
  /// See also [searchedSkills].
  SearchedSkillsProvider({
    String? keyword,
  }) : this._internal(
          (ref) => searchedSkills(
            ref as SearchedSkillsRef,
            keyword: keyword,
          ),
          from: searchedSkillsProvider,
          name: r'searchedSkillsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchedSkillsHash,
          dependencies: SearchedSkillsFamily._dependencies,
          allTransitiveDependencies:
              SearchedSkillsFamily._allTransitiveDependencies,
          keyword: keyword,
        );

  SearchedSkillsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.keyword,
  }) : super.internal();

  final String? keyword;

  @override
  Override overrideWith(
    FutureOr<List<SkillEntity>> Function(SearchedSkillsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchedSkillsProvider._internal(
        (ref) => create(ref as SearchedSkillsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        keyword: keyword,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SkillEntity>> createElement() {
    return _SearchedSkillsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchedSkillsProvider && other.keyword == keyword;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, keyword.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchedSkillsRef on AutoDisposeFutureProviderRef<List<SkillEntity>> {
  /// The parameter `keyword` of this provider.
  String? get keyword;
}

class _SearchedSkillsProviderElement
    extends AutoDisposeFutureProviderElement<List<SkillEntity>>
    with SearchedSkillsRef {
  _SearchedSkillsProviderElement(super.provider);

  @override
  String? get keyword => (origin as SearchedSkillsProvider).keyword;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
