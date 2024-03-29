import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'interview_topic_select_route_arg.g.dart';

@riverpod
InterviewType interviewTopicSelectRouteArg(
    InterviewTopicSelectRouteArgRef ref) {
  return InterviewTopicSelectRoute.arg;
}
