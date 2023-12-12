import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/topic/data/local/interview_topic_local_data_source.dart';
import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_category_model.dart';
import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_model.dart';
import 'package:techtalk/features/interview_new/topic/interview_topic.dart';
import 'package:techtalk/features/interview_new/topic/repositories/interview_topic_repository.dart';

class InterviewTopicRepositoryImpl implements InterviewTopicRepository {
  const InterviewTopicRepositoryImpl({
    required InterviewTopicLocalDataSource interviewLocalDataSource,
  }) : _interviewLocalDataSource = interviewLocalDataSource;
  final InterviewTopicLocalDataSource _interviewLocalDataSource;

  @override
  FutureOr<Result<List<InterviewTopicEntity>>> getTopics() {
    final topicModels =
        _interviewLocalDataSource.getTopics() as List<InterviewTopicModel>;

    return Result.success(
      [
        ...topicModels.map(
          (e) => e.toEntity(),
        ),
      ],
    );
  }

  @override
  FutureOr<Result<List<InterviewTopicCategoryEntity>>> getTopicCategories() {
    final categoryModels = _interviewLocalDataSource.getTopicCategories()
        as List<InterviewTopicCategoryModel>;

    return Result.success(
      [
        ...categoryModels.map(
          (e) => e.toEntity(),
        ),
      ],
    );
  }
}
