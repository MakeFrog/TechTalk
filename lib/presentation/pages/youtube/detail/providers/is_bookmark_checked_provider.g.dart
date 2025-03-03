// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_bookmark_checked_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isBookmarkCheckedHash() => r'2674d9a5e17f8f0510accacff140b4e46d837ed1';

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

abstract class _$IsBookmarkChecked
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final String contentId;

  Future<bool> build(
    String contentId,
  );
}

/// See also [IsBookmarkChecked].
@ProviderFor(IsBookmarkChecked)
const isBookmarkCheckedProvider = IsBookmarkCheckedFamily();

/// See also [IsBookmarkChecked].
class IsBookmarkCheckedFamily extends Family<AsyncValue<bool>> {
  /// See also [IsBookmarkChecked].
  const IsBookmarkCheckedFamily();

  /// See also [IsBookmarkChecked].
  IsBookmarkCheckedProvider call(
    String contentId,
  ) {
    return IsBookmarkCheckedProvider(
      contentId,
    );
  }

  @override
  IsBookmarkCheckedProvider getProviderOverride(
    covariant IsBookmarkCheckedProvider provider,
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
  String? get name => r'isBookmarkCheckedProvider';
}

/// See also [IsBookmarkChecked].
class IsBookmarkCheckedProvider
    extends AutoDisposeAsyncNotifierProviderImpl<IsBookmarkChecked, bool> {
  /// See also [IsBookmarkChecked].
  IsBookmarkCheckedProvider(
    String contentId,
  ) : this._internal(
          () => IsBookmarkChecked()..contentId = contentId,
          from: isBookmarkCheckedProvider,
          name: r'isBookmarkCheckedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isBookmarkCheckedHash,
          dependencies: IsBookmarkCheckedFamily._dependencies,
          allTransitiveDependencies:
              IsBookmarkCheckedFamily._allTransitiveDependencies,
          contentId: contentId,
        );

  IsBookmarkCheckedProvider._internal(
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
  Future<bool> runNotifierBuild(
    covariant IsBookmarkChecked notifier,
  ) {
    return notifier.build(
      contentId,
    );
  }

  @override
  Override overrideWith(IsBookmarkChecked Function() create) {
    return ProviderOverride(
      origin: this,
      override: IsBookmarkCheckedProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<IsBookmarkChecked, bool>
      createElement() {
    return _IsBookmarkCheckedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsBookmarkCheckedProvider && other.contentId == contentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsBookmarkCheckedRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `contentId` of this provider.
  String get contentId;
}

class _IsBookmarkCheckedProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<IsBookmarkChecked, bool>
    with IsBookmarkCheckedRef {
  _IsBookmarkCheckedProviderElement(super.provider);

  @override
  String get contentId => (origin as IsBookmarkCheckedProvider).contentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
