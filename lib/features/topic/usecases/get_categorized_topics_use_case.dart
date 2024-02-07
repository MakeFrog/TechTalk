import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

typedef CategorizedTopics = Map<TopicCategoryEntity, List<TopicEntity>>;

final class GetCategorizedTopicsUseCase {
  GetCategorizedTopicsUseCase(this._topicRepository);

  final TopicRepository _topicRepository;

  Result<CategorizedTopics> call() {
    try {
      final topics = StoredTopics.list
        ..sort(
          (a, b) => a.categoryId.compareTo(b.categoryId),
        );
      final categories = _topicRepository.getTopicCategories().getOrThrow();

      final resolvedTopics = CategorizedTopics();

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

      return Result.success(resolvedTopics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
