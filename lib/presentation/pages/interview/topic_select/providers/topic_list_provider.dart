import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'topic_list_provider.g.dart';

@riverpod
Future<List<InterviewTopicEntity>> topicList(TopicListRef ref) async {
  return getInterviewTopicListUseCase();
}