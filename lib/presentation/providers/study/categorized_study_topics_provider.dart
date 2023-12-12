import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/entities/interview_topic.enum.dart';
import 'package:techtalk/features/interview/entities/interview_topic_category.enum.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'categorized_study_topics_provider.g.dart';

@riverpod
Future<Map<InterviewTopicCategory, List<InterviewTopic>>>
    categorizedStudyTopics(
  CategorizedStudyTopicsRef ref,
) async {
  final topics = interviewRepository.getTopics().getOrThrow().toList()
    ..sort(
      (a, b) => a.category.text.compareTo(b.category.text),
    );

  final resolvedTopics = <InterviewTopicCategory, List<InterviewTopic>>{};

  for (final topic in topics) {
    if (resolvedTopics.containsKey(topic.category)) {
      resolvedTopics[topic.category]!.add(topic);
    } else {
      resolvedTopics[topic.category] = [topic];
    }
  }

  return resolvedTopics;
}
