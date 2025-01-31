// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeSummaryHash() => r'3e2271be3af1c5486221e64f37595181b09a119b';

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

abstract class _$YoutubeSummary
    extends BuildlessAutoDisposeAsyncNotifier<SummaryEntity> {
  late final String contentId;

  FutureOr<SummaryEntity> build(
    String contentId,
  );
}

/// See also [YoutubeSummary].
@ProviderFor(YoutubeSummary)
const youtubeSummaryProvider = YoutubeSummaryFamily();

/// See also [YoutubeSummary].
class YoutubeSummaryFamily extends Family<AsyncValue<SummaryEntity>> {
  /// See also [YoutubeSummary].
  const YoutubeSummaryFamily();

  /// See also [YoutubeSummary].
  YoutubeSummaryProvider call(
    String contentId,
  ) {
    return YoutubeSummaryProvider(
      contentId,
    );
  }

  @override
  YoutubeSummaryProvider getProviderOverride(
    covariant YoutubeSummaryProvider provider,
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
  String? get name => r'youtubeSummaryProvider';
}

/// See also [YoutubeSummary].
class YoutubeSummaryProvider extends AutoDisposeAsyncNotifierProviderImpl<
    YoutubeSummary, SummaryEntity> {
  /// See also [YoutubeSummary].
  YoutubeSummaryProvider(
    String contentId,
  ) : this._internal(
          () => YoutubeSummary()..contentId = contentId,
          from: youtubeSummaryProvider,
          name: r'youtubeSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeSummaryHash,
          dependencies: YoutubeSummaryFamily._dependencies,
          allTransitiveDependencies:
              YoutubeSummaryFamily._allTransitiveDependencies,
          contentId: contentId,
        );

  YoutubeSummaryProvider._internal(
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
  FutureOr<SummaryEntity> runNotifierBuild(
    covariant YoutubeSummary notifier,
  ) {
    return notifier.build(
      contentId,
    );
  }

  @override
  Override overrideWith(YoutubeSummary Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeSummaryProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<YoutubeSummary, SummaryEntity>
      createElement() {
    return _YoutubeSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeSummaryProvider && other.contentId == contentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeSummaryRef on AutoDisposeAsyncNotifierProviderRef<SummaryEntity> {
  /// The parameter `contentId` of this provider.
  String get contentId;
}

class _YoutubeSummaryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeSummary,
        SummaryEntity> with YoutubeSummaryRef {
  _YoutubeSummaryProviderElement(super.provider);

  @override
  String get contentId => (origin as YoutubeSummaryProvider).contentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
