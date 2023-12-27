import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

///
/// 면접 주제 리스트 호출.
///
final class GetTopicsUseCase {
  GetTopicsUseCase(
    this._topicRepository,
  );

  final TopicRepository _topicRepository;

  Result<List<TopicEntity>> call({
    bool includeUnavailable = false,
  }) {
    try {
      final topics = _topicRepository.getTopics().getOrThrow();

      return Result.success(
        [
          ...topics
              .where((element) => includeUnavailable || element.isAvailable),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
