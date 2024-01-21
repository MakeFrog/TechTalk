import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/practical_chat_room_list_provider.dart';

part 'interview_rooms_provider.g.dart';

@Riverpod(dependencies: [chatListRouteArg])
class InterviewRooms extends _$InterviewRooms {
  @override
  FutureOr<List<ChatRoomEntity>> build() async {
    final type = ref.read(chatListRouteArgProvider).interviewType;
    final topic = ref.read(chatListRouteArgProvider).topic;

    if (type.isPractical) {
      return ref.read(practicalChatRoomListProvider.future);
    } else {
      final response = await getChatRoomsUseCase(type, topic);

      return response.fold(
        onSuccess: (chatList) {
          return chatList;
        },
        onFailure: (e) {
          log(e.toString());
          throw e;
        },
      );
    }
  }
}
