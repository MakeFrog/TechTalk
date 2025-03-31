// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listed_selectable_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listedSelectableQnasProviderHash() =>
    r'fb6c746ce20a7e4b91c4641819e75f937eca32b5';

/// See also [ListedSelectableQnasProvider].
@ProviderFor(ListedSelectableQnasProvider)
final listedSelectableQnasProviderProvider = AutoDisposeAsyncNotifierProvider<
    ListedSelectableQnasProvider,
    List<SelectableQnaEntity<BaseQnaEntity>>>.internal(
  ListedSelectableQnasProvider.new,
  name: r'listedSelectableQnasProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listedSelectableQnasProviderHash,
  dependencies: <ProviderOrFamily>[createdQuestionListRouteArgProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    createdQuestionListRouteArgProvider,
    ...?createdQuestionListRouteArgProvider.allTransitiveDependencies
  },
);

typedef _$ListedSelectableQnasProvider
    = AutoDisposeAsyncNotifier<List<SelectableQnaEntity<BaseQnaEntity>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
