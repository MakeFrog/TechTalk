import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/route_arg_container.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/topic/entities/topic_entity.dart';

part 'chat_list_route_arg.g.dart';

@Riverpod()
ChatListRouteArg chatListRouteArg(ChatListRouteArgRef ref) {
  return RouteArgContainer.arg;
}

typedef ChatListRouteArg = ({TopicEntity? topic, InterviewType interviewType});
