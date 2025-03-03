// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_content_qna_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$youtubeContentQnaHash() => r'17c9b9710487ad5b807c1497500611baa0ecdfd4';

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

abstract class _$YoutubeContentQna
    extends BuildlessAutoDisposeAsyncNotifier<List<YoutubeQnaEntity>> {
  late final String contentId;

  Future<List<YoutubeQnaEntity>> build({
    required String contentId,
  });
}

/// See also [YoutubeContentQna].
@ProviderFor(YoutubeContentQna)
const youtubeContentQnaProvider = YoutubeContentQnaFamily();

/// See also [YoutubeContentQna].
class YoutubeContentQnaFamily
    extends Family<AsyncValue<List<YoutubeQnaEntity>>> {
  /// See also [YoutubeContentQna].
  const YoutubeContentQnaFamily();

  /// See also [YoutubeContentQna].
  YoutubeContentQnaProvider call({
    required String contentId,
  }) {
    return YoutubeContentQnaProvider(
      contentId: contentId,
    );
  }

  @override
  YoutubeContentQnaProvider getProviderOverride(
    covariant YoutubeContentQnaProvider provider,
  ) {
    return call(
      contentId: provider.contentId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    youtubeDetailRouteArgProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    youtubeDetailRouteArgProvider,
    ...?youtubeDetailRouteArgProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'youtubeContentQnaProvider';
}

/// See also [YoutubeContentQna].
class YoutubeContentQnaProvider extends AutoDisposeAsyncNotifierProviderImpl<
    YoutubeContentQna, List<YoutubeQnaEntity>> {
  /// See also [YoutubeContentQna].
  YoutubeContentQnaProvider({
    required String contentId,
  }) : this._internal(
          () => YoutubeContentQna()..contentId = contentId,
          from: youtubeContentQnaProvider,
          name: r'youtubeContentQnaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$youtubeContentQnaHash,
          dependencies: YoutubeContentQnaFamily._dependencies,
          allTransitiveDependencies:
              YoutubeContentQnaFamily._allTransitiveDependencies,
          contentId: contentId,
        );

  YoutubeContentQnaProvider._internal(
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
  Future<List<YoutubeQnaEntity>> runNotifierBuild(
    covariant YoutubeContentQna notifier,
  ) {
    return notifier.build(
      contentId: contentId,
    );
  }

  @override
  Override overrideWith(YoutubeContentQna Function() create) {
    return ProviderOverride(
      origin: this,
      override: YoutubeContentQnaProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<YoutubeContentQna,
      List<YoutubeQnaEntity>> createElement() {
    return _YoutubeContentQnaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YoutubeContentQnaProvider && other.contentId == contentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin YoutubeContentQnaRef
    on AutoDisposeAsyncNotifierProviderRef<List<YoutubeQnaEntity>> {
  /// The parameter `contentId` of this provider.
  String get contentId;
}

class _YoutubeContentQnaProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<YoutubeContentQna,
        List<YoutubeQnaEntity>> with YoutubeContentQnaRef {
  _YoutubeContentQnaProviderElement(super.provider);

  @override
  String get contentId => (origin as YoutubeContentQnaProvider).contentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
