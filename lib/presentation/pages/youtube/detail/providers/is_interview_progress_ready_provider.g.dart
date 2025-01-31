// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_interview_progress_ready_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isInterviewProgressReadyHash() =>
    r'6046d88327706e4d78e8207edd65da063075bf14';

/// See also [IsInterviewProgressReady].
@ProviderFor(IsInterviewProgressReady)
final isInterviewProgressReadyProvider =
    AutoDisposeNotifierProvider<IsInterviewProgressReady, bool>.internal(
  IsInterviewProgressReady.new,
  name: r'isInterviewProgressReadyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isInterviewProgressReadyHash,
  dependencies: <ProviderOrFamily>[
    youtubeDetailRouteArgProvider,
    youtubeContentQnaProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    youtubeDetailRouteArgProvider,
    ...?youtubeDetailRouteArgProvider.allTransitiveDependencies,
    youtubeContentQnaProvider,
    ...?youtubeContentQnaProvider.allTransitiveDependencies
  },
);

typedef _$IsInterviewProgressReady = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
