// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorized_study_topics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categorizedStudyTopicsHash() =>
    r'7affb087083beb5cbbb63af95968e7f85aa606ab';

/// See also [categorizedStudyTopics].
@ProviderFor(categorizedStudyTopics)
final categorizedStudyTopicsProvider =
    AutoDisposeFutureProvider<Map<TopicCategory, List<Topic>>>.internal(
  categorizedStudyTopics,
  name: r'categorizedStudyTopicsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categorizedStudyTopicsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CategorizedStudyTopicsRef
    = AutoDisposeFutureProviderRef<Map<TopicCategory, List<Topic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
