import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

///
/// 면접 주제 리스트 호출.
///
final class GetTopicsUseCase {
  Result<List<TopicEntity>> call({
    bool includeUnavailable = false,
  }) {
    try {
      return Result.success(
        [
          ...StoredTopics.list
              .where((element) => includeUnavailable || element.isAvailable),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
