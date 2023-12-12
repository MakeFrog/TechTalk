import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/entities/interview_topic.enum.dart';
import 'package:techtalk/features/interview_new/repositories/interview_repository.dart';

final class GetInterviewTopicListUseCase
    extends BaseNoParamUseCase<Result<List<InterviewTopic>>> {
  GetInterviewTopicListUseCase({
    required InterviewRepository interviewRepository,
  }) : _interviewRepository = interviewRepository;

  final InterviewRepository _interviewRepository;

  @override
  Future<Result<List<InterviewTopic>>> call() async {
    try {
      final topics = [..._interviewRepository.getTopics().getOrThrow()];

      return Result.success(topics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
