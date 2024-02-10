import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/topic/topic.dart';

///
/// 면접 주제 리스트 호출.
///
final class GetTopicsUseCase {
  List<TopicEntity> call({
    bool includeUnavailable = false,
  }) {
    return StoredTopics.list
        .where((element) => includeUnavailable || element.isAvailable)
        .toList();
  }
}
