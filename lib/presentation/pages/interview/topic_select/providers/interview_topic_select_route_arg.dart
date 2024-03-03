import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';

part 'interview_topic_select_route_arg.g.dart';

@riverpod
InterviewType interviewTopicSelectRouteArg(
    InterviewTopicSelectRouteArgRef ref) {
  return InterviewTopicSelectRoute.arg;
}
