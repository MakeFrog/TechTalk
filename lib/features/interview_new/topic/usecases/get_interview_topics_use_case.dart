import 'dart:async';

import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/topic/interview_topic.dart';
import 'package:techtalk/features/interview_new/topic/repositories/interview_topic_repository.dart';

final class GetInterviewTopicsUseCase
    extends BaseNoParamUseCase<Result<List<InterviewTopicEntity>>> {
  GetInterviewTopicsUseCase({
    required InterviewTopicRepository interviewRepository,
  }) : _interviewRepository = interviewRepository;

  final InterviewTopicRepository _interviewRepository;

  @override
  FutureOr<Result<List<InterviewTopicEntity>>> call() async {
    try {
      final topicsResult = await _interviewRepository.getTopics();

      return Result.success(
        [
          ...topicsResult.getOrThrow(),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
