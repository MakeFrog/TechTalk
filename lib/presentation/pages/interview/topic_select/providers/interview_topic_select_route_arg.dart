import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/route_arg_container.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';

part 'interview_topic_select_route_arg.g.dart';

@riverpod
InterviewType interviewTopicSelectRouteArg(
    InterviewTopicSelectRouteArgRef ref) {
  return RouteArgContainer.arg;
}
