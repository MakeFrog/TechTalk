// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelDetailHash() => r'f1c3f474e26656f259e45a0d5eb10d2cf9cebdd0';

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

abstract class _$ChannelDetail
    extends BuildlessAutoDisposeAsyncNotifier<ChannelDetailEntity> {
  late final String channelId;

  Future<ChannelDetailEntity> build(
    String channelId,
  );
}

/// See also [ChannelDetail].
@ProviderFor(ChannelDetail)
const channelDetailProvider = ChannelDetailFamily();

/// See also [ChannelDetail].
class ChannelDetailFamily extends Family<AsyncValue<ChannelDetailEntity>> {
  /// See also [ChannelDetail].
  const ChannelDetailFamily();

  /// See also [ChannelDetail].
  ChannelDetailProvider call(
    String channelId,
  ) {
    return ChannelDetailProvider(
      channelId,
    );
  }

  @override
  ChannelDetailProvider getProviderOverride(
    covariant ChannelDetailProvider provider,
  ) {
    return call(
      provider.channelId,
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
  String? get name => r'channelDetailProvider';
}

/// See also [ChannelDetail].
class ChannelDetailProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChannelDetail, ChannelDetailEntity> {
  /// See also [ChannelDetail].
  ChannelDetailProvider(
    String channelId,
  ) : this._internal(
          () => ChannelDetail()..channelId = channelId,
          from: channelDetailProvider,
          name: r'channelDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelDetailHash,
          dependencies: ChannelDetailFamily._dependencies,
          allTransitiveDependencies:
              ChannelDetailFamily._allTransitiveDependencies,
          channelId: channelId,
        );

  ChannelDetailProvider._internal(
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
  Future<ChannelDetailEntity> runNotifierBuild(
    covariant ChannelDetail notifier,
  ) {
    return notifier.build(
      channelId,
    );
  }

  @override
  Override overrideWith(ChannelDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelDetailProvider._internal(
        () => create()..channelId = channelId,
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
  AutoDisposeAsyncNotifierProviderElement<ChannelDetail, ChannelDetailEntity>
      createElement() {
    return _ChannelDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelDetailProvider && other.channelId == channelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelDetailRef
    on AutoDisposeAsyncNotifierProviderRef<ChannelDetailEntity> {
  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _ChannelDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChannelDetail,
        ChannelDetailEntity> with ChannelDetailRef {
  _ChannelDetailProviderElement(super.provider);

  @override
  String get channelId => (origin as ChannelDetailProvider).channelId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
