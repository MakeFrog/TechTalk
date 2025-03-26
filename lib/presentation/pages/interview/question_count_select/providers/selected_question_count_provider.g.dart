// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_question_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedQuestionCountHash() =>
    r'eaf103cc8eb0bf692e00c6a29236db1620830b68';

/// See also [SelectedQuestionCount].
@ProviderFor(SelectedQuestionCount)
final selectedQuestionCountProvider =
    AutoDisposeNotifierProvider<SelectedQuestionCount, int>.internal(
  SelectedQuestionCount.new,
  name: r'selectedQuestionCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedQuestionCountHash,
  dependencies: <ProviderOrFamily>[selectedQuestionCountRouteArgProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedQuestionCountRouteArgProvider,
    ...?selectedQuestionCountRouteArgProvider.allTransitiveDependencies
  },
);

typedef _$SelectedQuestionCount = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
