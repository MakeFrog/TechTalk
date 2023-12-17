import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/topic/topics_provider.dart';

part 'categorized_topics_provider.g.dart';

@riverpod
Map<TopicCategory, List<Topic>> categorizedTopics(
  CategorizedTopicsRef ref,
) {
  final topics = ref.watch(topicsProvider).requireValue
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
