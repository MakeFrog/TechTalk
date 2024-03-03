import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

part 'chat_list_route_arg.g.dart';

@riverpod
ChatListRouteArg chatListRouteArg(ChatListRouteArgRef ref) {
  return ChatListRoute.arg;
}

typedef ChatListRouteArg = ({
  TopicEntity? topic,
  InterviewType interviewType,
  List<ChatRoomEntity>? chatRooms
});
