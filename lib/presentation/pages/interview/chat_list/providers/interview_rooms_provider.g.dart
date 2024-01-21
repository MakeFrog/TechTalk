// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$interviewRoomsHash() => r'b207156546eca144dd1f1d16b32c5ff3b406bfd7';

/// See also [InterviewRooms].
@ProviderFor(InterviewRooms)
final interviewRoomsProvider = AutoDisposeAsyncNotifierProvider<InterviewRooms,
    List<ChatRoomEntity>>.internal(
  InterviewRooms.new,
  name: r'interviewRoomsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$interviewRoomsHash,
  dependencies: <ProviderOrFamily>[chatListRouteArgProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    chatListRouteArgProvider,
    ...?chatListRouteArgProvider.allTransitiveDependencies
  },
);

typedef _$InterviewRooms = AutoDisposeAsyncNotifier<List<ChatRoomEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
