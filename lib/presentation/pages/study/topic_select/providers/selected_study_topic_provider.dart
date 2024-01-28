import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/route_arg_container.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
TopicEntity selectedStudyTopic(SelectedStudyTopicRef ref) {
  return RouteArgContainer.arg;
}
