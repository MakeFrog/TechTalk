// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interested_job_group_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobGroupListHash() => r'22519dde47e6ca049355af5da62a92556498eeac';

/// See also [jobGroupList].
@ProviderFor(jobGroupList)
final jobGroupListProvider =
    AutoDisposeFutureProvider<JobGroupListModel>.internal(
  jobGroupList,
  name: r'jobGroupListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobGroupListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JobGroupListRef = AutoDisposeFutureProviderRef<JobGroupListModel>;
String _$interestedJobGroupListHash() =>
    r'739ddc5b7da903aaab4dd5ab65954203d10f62f2';

/// See also [InterestedJobGroupList].
@ProviderFor(InterestedJobGroupList)
final interestedJobGroupListProvider = AutoDisposeNotifierProvider<
    InterestedJobGroupList, List<JobGroupModel>>.internal(
  InterestedJobGroupList.new,
  name: r'interestedJobGroupListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$interestedJobGroupListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InterestedJobGroupList = AutoDisposeNotifier<List<JobGroupModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
