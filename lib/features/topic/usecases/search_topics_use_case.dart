import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SearchTopicsUseCase {
  SearchTopicsUseCase();

  Result<List<TopicEntity>> call(String keyword) {
    // TODO : repo에 매소드 추가
    final topics = getTopicsUseCase().getOrThrow();

    return Result.success([
      ...topics.where(
        (e) => e.text.toLowerCase().startsWith(
              keyword.toLowerCase(),
            ),
      ),
    ]);
  }
}
