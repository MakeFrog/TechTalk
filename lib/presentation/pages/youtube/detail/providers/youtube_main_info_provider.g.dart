// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_main_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeMainInfoHash() => r'5ac599e7befb0788f41a11b7eadc64ec4ae00073';

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

abstract class _$YoutubeMainInfo
    extends BuildlessAutoDisposeAsyncNotifier<YoutubeMainEntity> {
  late final String contentId;

  Future<YoutubeMainEntity> build(
    String contentId,
  );
}

/// See also [YoutubeMainInfo].
@ProviderFor(YoutubeMainInfo)
const youtubeMainInfoProvider = YoutubeMainInfoFamily();

/// See also [YoutubeMainInfo].
class YoutubeMainInfoFamily extends Family<AsyncValue<YoutubeMainEntity>> {
  /// See also [YoutubeMainInfo].
  const YoutubeMainInfoFamily();

  /// See also [YoutubeMainInfo].
  YoutubeMainInfoProvider call(
    String contentId,
  ) {
    return YoutubeMainInfoProvider(
      contentId,
    );
  }

  @override
  YoutubeMainInfoProvider getProviderOverride(
    covariant YoutubeMainInfoProvider provider,
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
  String? get name => r'youtubeMainInfoProvider';
}

/// See also [YoutubeMainInfo].
class YoutubeMainInfoProvider extends AutoDisposeAsyncNotifierProviderImpl<
    YoutubeMainInfo, YoutubeMainEntity> {
  /// See also [YoutubeMainInfo].
  YoutubeMainInfoProvider(
    String contentId,
  ) : this._internal(
          () => YoutubeMainInfo()..contentId = contentId,
          from: youtubeMainInfoProvider,
          name: r'youtubeMainInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeMainInfoHash,
          dependencies: YoutubeMainInfoFamily._dependencies,
          allTransitiveDependencies:
              YoutubeMainInfoFamily._allTransitiveDependencies,
          contentId: contentId,
        );

  YoutubeMainInfoProvider._internal(
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
  Future<YoutubeMainEntity> runNotifierBuild(
    covariant YoutubeMainInfo notifier,
  ) {
    return notifier.build(
      contentId,
    );
  }

  @override
  Override overrideWith(YoutubeMainInfo Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeMainInfoProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<YoutubeMainInfo, YoutubeMainEntity>
      createElement() {
    return _YoutubeMainInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeMainInfoProvider && other.contentId == contentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeMainInfoRef
    on AutoDisposeAsyncNotifierProviderRef<YoutubeMainEntity> {
  /// The parameter `contentId` of this provider.
  String get contentId;
}

class _YoutubeMainInfoProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeMainInfo,
        YoutubeMainEntity> with YoutubeMainInfoRef {
  _YoutubeMainInfoProviderElement(super.provider);

  @override
  String get contentId => (origin as YoutubeMainInfoProvider).contentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
