// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interested_job_group_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobGroupListHash() => r'9c2da96d8b2552c611ef4364c3beb81ebe70f04d';

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
    r'a468a969f6bb95d9b0097f9194d5ad61a50fa531';

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
