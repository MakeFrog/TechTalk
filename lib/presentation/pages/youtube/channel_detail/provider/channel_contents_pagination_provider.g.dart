// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_contents_pagination_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelContentsPaginationHash() =>
    r'f7aa01ede1b15f4e7c7fec127bc013e7c9db6d18';

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

/// See also [channelContentsPagination].
@ProviderFor(channelContentsPagination)
const channelContentsPaginationProvider = ChannelContentsPaginationFamily();

/// See also [channelContentsPagination].
class ChannelContentsPaginationFamily extends Family<
    PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>> {
  /// See also [channelContentsPagination].
  const ChannelContentsPaginationFamily();

  /// See also [channelContentsPagination].
  ChannelContentsPaginationProvider call({
    required String channelId,
  }) {
    return ChannelContentsPaginationProvider(
      channelId: channelId,
    );
  }

  @override
  ChannelContentsPaginationProvider getProviderOverride(
    covariant ChannelContentsPaginationProvider provider,
  ) {
    return call(
      channelId: provider.channelId,
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
  String? get name => r'channelContentsPaginationProvider';
}

/// See also [channelContentsPagination].
class ChannelContentsPaginationProvider extends AutoDisposeProvider<
    PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>> {
  /// See also [channelContentsPagination].
  ChannelContentsPaginationProvider({
    required String channelId,
  }) : this._internal(
          (ref) => channelContentsPagination(
            ref as ChannelContentsPaginationRef,
            channelId: channelId,
          ),
          from: channelContentsPaginationProvider,
          name: r'channelContentsPaginationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelContentsPaginationHash,
          dependencies: ChannelContentsPaginationFamily._dependencies,
          allTransitiveDependencies:
              ChannelContentsPaginationFamily._allTransitiveDependencies,
          channelId: channelId,
        );

  ChannelContentsPaginationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelId,
  }) : super.internal();

  final String channelId;

  @override
  Override overrideWith(
    PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>
            Function(ChannelContentsPaginationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChannelContentsPaginationProvider._internal(
        (ref) => create(ref as ChannelContentsPaginationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelId: channelId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<
      PagingController<DocumentSnapshot<YoutubeMainModel>?,
          YoutubeMainEntity>> createElement() {
    return _ChannelContentsPaginationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelContentsPaginationProvider &&
        other.channelId == channelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelContentsPaginationRef on AutoDisposeProviderRef<
    PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>> {
  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _ChannelContentsPaginationProviderElement
    extends AutoDisposeProviderElement<
        PagingController<DocumentSnapshot<YoutubeMainModel>?,
            YoutubeMainEntity>> with ChannelContentsPaginationRef {
  _ChannelContentsPaginationProviderElement(super.provider);

  @override
  String get channelId =>
      (origin as ChannelContentsPaginationProvider).channelId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
