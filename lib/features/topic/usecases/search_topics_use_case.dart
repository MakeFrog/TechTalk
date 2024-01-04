import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SearchTopicsUseCase {
  SearchTopicsUseCase();

  Result<List<TopicEntity>> call(String keyword) {
    if (keyword.isEmpty) {
      return Result.success([]);
    }

    final topics = getTopicsUseCase(includeUnavailable: true).getOrThrow();

    return Result.success([
      ...topics.where(
        (e) => e.text.toLowerCase().startsWith(
              keyword.toLowerCase(),
            ),
      ),
    ]);
  }
}
