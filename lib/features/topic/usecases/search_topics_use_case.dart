import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SearchTopicsUseCase {
  SearchTopicsUseCase(this._topicRepository);

  final TopicRepository _topicRepository;

  Future<Result<List<Topic>>> call(String keyword) async {
    return _topicRepository.searchTopics(keyword);
  }
}
