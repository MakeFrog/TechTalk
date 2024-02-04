import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/practical_chat_room_list_provider.dart';

part 'interview_rooms_provider.g.dart';

@Riverpod()
class InterviewRooms extends _$InterviewRooms {
  @override
  FutureOr<List<ChatRoomEntity>> build() async {
    final passedArg = ref.read(chatListRouteArgProvider);

    final type = passedArg.interviewType;
    final topic = passedArg.topic;
    final passedChatRooms = passedArg.chatRooms;

    if (passedArg.interviewType.isPractical) {
      if (passedChatRooms != null && passedChatRooms.isNotEmpty) {
        return passedChatRooms;
      } else {
        return ref.watch(practicalChatRoomListProvider.future);
      }
    } else {
      final response = await getChatRoomsUseCase(
          type, topic ?? ref.read(selectedChatRoomProvider).singleTopic);

      return response.fold(
        onSuccess: (chatList) => chatList,
        onFailure: (e) {
          log(e.toString());
          throw e;
        },
      );
    }
  }

  void synchronizeRooms(ChatRoomEntity currentRoom) {
    update((prev) {
      prev.removeWhere((e) => e.id == currentRoom.id);
      return [currentRoom, ...prev];
    });
  }
}
