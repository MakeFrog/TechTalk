import 'dart:async';

import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_category_model.dart';
import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_model.dart';

abstract interface class InterviewTopicLocalDataSource {
  /// 주제 리스트를 조회한다.
  FutureOr<List<InterviewTopicModel>> getTopics();

  /// 주제 카테고리 리스트를 조회한다.
  FutureOr<List<InterviewTopicCategoryModel>> getTopicCategories();
}
