// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_study_topic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedStudyTopicIdHash() =>
    r'eba5358ffd686b95d9ddd1dde0c8dffc8a044578';

/// See also [selectedStudyTopicId].
@ProviderFor(selectedStudyTopicId)
final selectedStudyTopicIdProvider = AutoDisposeProvider<String>.internal(
  selectedStudyTopicId,
  name: r'selectedStudyTopicIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedStudyTopicIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedStudyTopicIdRef = AutoDisposeProviderRef<String>;
String _$selectedStudyTopicHash() =>
    r'01bcb33982e750456c81912e04d8b8f9212707ba';

/// See also [SelectedStudyTopic].
@ProviderFor(SelectedStudyTopic)
final selectedStudyTopicProvider =
    AutoDisposeNotifierProvider<SelectedStudyTopic, InterviewTopic>.internal(
  SelectedStudyTopic.new,
  name: r'selectedStudyTopicProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedStudyTopicHash,
  dependencies: <ProviderOrFamily>[selectedStudyTopicIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedStudyTopicIdProvider,
    ...?selectedStudyTopicIdProvider.allTransitiveDependencies
  },
);

typedef _$SelectedStudyTopic = AutoDisposeNotifier<InterviewTopic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
