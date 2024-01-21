import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/topic/entities/topic_entity.dart';

part 'chat_list_route_arg.g.dart';

@riverpod
ChatListRouteArg chatListRouteArg(ChatListRouteArgRef ref) {
  throw UnimplementedError('Unexpected Route Argument');
}

typedef ChatListRouteArg = ({TopicEntity? topic, InterviewType interviewType});
