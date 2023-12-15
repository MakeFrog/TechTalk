// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_questions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studyQuestionsHash() => r'038c40b7dab9cbfeaef057b5527412897b0531c7';

/// See also [StudyQuestions].
@ProviderFor(StudyQuestions)
final studyQuestionsProvider = AutoDisposeAsyncNotifierProvider<StudyQuestions,
    List<InterviewQuestionEntity>>.internal(
  StudyQuestions.new,
  name: r'studyQuestionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studyQuestionsHash,
  dependencies: <ProviderOrFamily>[selectedStudyTopicIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedStudyTopicIdProvider,
    ...?selectedStudyTopicIdProvider.allTransitiveDependencies
  },
);

typedef _$StudyQuestions
    = AutoDisposeAsyncNotifier<List<InterviewQuestionEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
