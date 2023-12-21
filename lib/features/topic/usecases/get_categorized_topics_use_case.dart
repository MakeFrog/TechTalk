import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetCategorizedTopicsUseCase {
  GetCategorizedTopicsUseCase(this._topicRepository);

  final TopicRepository _topicRepository;

  Result<Map<TopicCategoryEntity, List<TopicEntity>>> call() {
    try {
      final topics = _topicRepository.getTopics().getOrThrow()
        ..sort(
          (a, b) => a.categoryId.compareTo(b.categoryId),
        );
      final categories = _topicRepository.getTopicCategories().getOrThrow();

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

      return Result.success(resolvedTopics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
