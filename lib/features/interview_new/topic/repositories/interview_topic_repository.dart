import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/topic/interview_topic.dart';

abstract interface class InterviewTopicRepository {
  FutureOr<Result<List<InterviewTopicEntity>>> getTopics();
  FutureOr<Result<List<InterviewTopicCategoryEntity>>> getTopicCategories();
}
