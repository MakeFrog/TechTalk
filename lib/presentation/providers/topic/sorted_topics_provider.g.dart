// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorted_topics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortedTopicsHash() => r'18f6b49cf711ac92719a9fbeb0a8a7d3160be9d0';

///
/// 제공되는 전체 면접 주제(Topic) 리스트에서
/// 2가지 기준으로 정렬 및 필터링된 리스트
/// - 유저의 관심 스킬과 관련된 면접 주제를 리스트 맨 앞으로 위치
/// - 현재 유효하지 않은 면접 주제는 리스트에서 제외
///
///
/// Copied from [SortedTopics].
@ProviderFor(SortedTopics)
final sortedTopicsProvider =
    AutoDisposeNotifierProvider<SortedTopics, List<TopicEntity>>.internal(
  SortedTopics.new,
  name: r'sortedTopicsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortedTopicsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SortedTopics = AutoDisposeNotifier<List<TopicEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
