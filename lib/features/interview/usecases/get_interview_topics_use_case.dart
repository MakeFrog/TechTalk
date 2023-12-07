import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/features/user/user.dart';

///
/// 면접 주제 리스트 호출.
/// 전체 면접 주제들중에 유저의 테크 주제 리스트를 우선적으로 정렬하여 보여줌
///
final class GetInterviewTopicListUseCase
    extends BaseNoParamUseCase<Result<List<InterviewTopic>>> {
  GetInterviewTopicListUseCase({
    required InterviewRepository interviewRepository,
  }) : _interviewRepository = interviewRepository;

  final InterviewRepository _interviewRepository;

  @override
  Future<Result<List<InterviewTopic>>> call({
    bool sort = false,
  }) async {
    try {
      final topics = [..._interviewRepository.getTopics().getOrThrow()];

      if (sort) {
        final userTopics = await getUserInterviewTopicsUseCase();

        for (InterviewTopic topic in userTopics) {
          if (topics.contains(topic)) {
            topics.remove(topic);
            topics.insert(0, topic);
          }
        }
      }

      return Result.success(topics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
