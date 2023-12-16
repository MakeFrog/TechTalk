import 'package:techtalk/core/constants/stored_topics.dart';
import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

///
/// 면접 주제 리스트 호출.
/// 전체 면접 주제들중에 유저의 테크 주제 리스트를 우선적으로 정렬하여 보여줌
///
final class GetInterviewTopicListUseCase
    extends BaseNoParamUseCase<Result<List<TopicEntity>>> {
  GetInterviewTopicListUseCase({
    required InterviewRepository interviewRepository,
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Result<List<TopicEntity>>> call({
    bool sort = false,
  }) async {
    final response = StoredTopics.list;
    final topics = response;

    if (sort) {
      final userTopicIdsRes = await _userRepository.getUserTopicList();
      final userTopics = userTopicIdsRes.getOrThrow().toList();

      for (TopicEntity topic in userTopics) {
        if (topics.contains(topic)) {
          topics.remove(topic);
          topics.insert(0, topic);
        }
      }
    }

    return Result.success(topics);
  }
}
