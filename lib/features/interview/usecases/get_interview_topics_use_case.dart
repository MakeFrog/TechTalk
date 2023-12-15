import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

///
/// 면접 주제 리스트 호출.
/// 전체 면접 주제들중에 유저의 테크 주제 리스트를 우선적으로 정렬하여 보여줌
///
final class GetInterviewTopicListUseCase
    extends BaseNoParamUseCase<Result<List<InterviewTopic>>> {
  GetInterviewTopicListUseCase({
    required InterviewRepository interviewRepository,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _interviewRepository = interviewRepository;

  final InterviewRepository _interviewRepository;
  final UserRepository _userRepository;

  @override
  Future<Result<List<InterviewTopic>>> call({
    bool sort = false,
  }) async {
    final topics = _interviewRepository.getTopics().getOrThrow().toList();

    if (sort) {
      final userTopicIdsRes = await _userRepository.getUserTopicIds();
      final userTopics = userTopicIdsRes
          .getOrThrow()
          .map((e) => InterviewTopic.getTopicById(e))
          .toList();

      for (InterviewTopic topic in userTopics) {
        if (topics.contains(topic)) {
          topics.remove(topic);
          topics.insert(0, topic);
        }
      }
    }

    return Result.success(topics);
  }
}
