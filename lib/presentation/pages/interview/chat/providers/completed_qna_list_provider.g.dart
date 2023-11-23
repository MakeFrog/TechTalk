// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_qna_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completedQnAListHash() => r'fc6d8ab644e03c6c2a838ab8639cfcf99f2bec1d';

///
/// [totalQnaListProvider]의 QnA 리스트 중
/// 유저의 응답의 정답 확인 완료된 QnA리스트만 필터링된 값을 반환하는 provider
///
///
/// Copied from [completedQnAList].
@ProviderFor(completedQnAList)
final completedQnAListProvider =
    AutoDisposeProvider<AsyncValue<List<InterviewQnAEntity>>>.internal(
  completedQnAList,
  name: r'completedQnAListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedQnAListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompletedQnAListRef
    = AutoDisposeProviderRef<AsyncValue<List<InterviewQnAEntity>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member