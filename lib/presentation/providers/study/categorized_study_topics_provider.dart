import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'categorized_study_topics_provider.g.dart';

@riverpod
Future<Map<TopicCategory, List<Topic>>> categorizedStudyTopics(
  CategorizedStudyTopicsRef ref,
) async {
  final topics = (await getTopicsUseCase()).getOrThrow()
    ..sort(
      (a, b) => a.category.text.compareTo(b.category.text),
    );

  final resolvedTopics = <TopicCategory, List<Topic>>{};

  for (final topic in topics) {
    if (resolvedTopics.containsKey(topic.category)) {
      resolvedTopics[topic.category]!.add(topic);
    } else {
      resolvedTopics[topic.category] = [topic];
    }
  }

  return resolvedTopics;
}
