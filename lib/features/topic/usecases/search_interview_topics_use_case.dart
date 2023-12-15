import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SearchInterviewTopicsUseCase {
  SearchInterviewTopicsUseCase(this._topicRepository);

  final TopicRepository _topicRepository;

  Future<Result<List<Topic>>> call(String keyword) async {
    return _topicRepository.searchTopics(keyword);
  }
}
