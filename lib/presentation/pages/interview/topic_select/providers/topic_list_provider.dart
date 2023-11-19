import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'topic_list_provider.g.dart';

@riverpod
Future<List<InterviewTopic>> topicList(TopicListRef ref) async {
  await Future.delayed(3.seconds);

  return getInterviewTopicListUseCase();
}
