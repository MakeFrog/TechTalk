// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_progress_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$interviewProgressStateHash() =>
    r'ec42c94257b9529a2587345eb1346080443275eb';

/// See also [InterviewProgressState].
@ProviderFor(InterviewProgressState)
final interviewProgressStateProvider = AutoDisposeNotifierProvider<
    InterviewProgressState, InterviewProgress>.internal(
  InterviewProgressState.new,
  name: r'interviewProgressStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$interviewProgressStateHash,
  dependencies: <ProviderOrFamily>[
    selectedChatRoomProvider,
    chatMessageHistoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedChatRoomProvider,
    ...?selectedChatRoomProvider.allTransitiveDependencies,
    chatMessageHistoryProvider,
    ...?chatMessageHistoryProvider.allTransitiveDependencies
  },
);

typedef _$InterviewProgressState = AutoDisposeNotifier<InterviewProgress>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
