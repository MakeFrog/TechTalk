import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'categorized_topics_provider.g.dart';

@riverpod
Map<TopicCategoryEntity, List<TopicEntity>> categorizedTopics(
  CategorizedTopicsRef ref,
) {
  final topics = getTopicsUseCase().getOrThrow()
    ..sort(
      (a, b) => a.categoryId.compareTo(b.categoryId),
    );
  final categories = topicRepository.getTopicCategories().getOrThrow();

  final resolvedTopics = <TopicCategoryEntity, List<TopicEntity>>{};

  for (final topic in topics) {
    final category = categories.firstWhere(
      (element) => element.id == topic.categoryId,
    );
    if (resolvedTopics.containsKey(category)) {
      resolvedTopics[category]!.add(topic);
    } else {
      resolvedTopics[category] = [topic];
    }
  }

  return resolvedTopics;
}
