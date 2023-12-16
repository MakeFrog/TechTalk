import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/stored_topics.dart';
import 'package:techtalk/features/interview/entities/interview_topic_category.enum.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

part 'categorized_study_topics_provider.g.dart';

@riverpod
Future<Map<InterviewTopicCategory, List<TopicEntity>>> categorizedStudyTopics(
  CategorizedStudyTopicsRef ref,
) async {
  final response = StoredTopics.list;

  final topics = response.toList()
    ..sort(
      (a, b) => a.category.text.compareTo(b.category.text),
    );

  final resolvedTopics = <InterviewTopicCategory, List<TopicEntity>>{};

  for (final topic in topics) {
    if (resolvedTopics.containsKey(topic)) {
      resolvedTopics[topic.category]!.add(topic);
    } else {
      resolvedTopics[topic.category] = [topic];
    }
  }

  return resolvedTopics;
}
