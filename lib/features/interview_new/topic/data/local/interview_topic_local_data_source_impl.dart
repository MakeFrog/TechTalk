import 'dart:async';

import 'package:techtalk/features/interview_new/topic/data/local/interview_topic_local_data_source.dart';
import 'package:techtalk/features/interview_new/topic/data/models/enum/interview_topic.enum.dart';
import 'package:techtalk/features/interview_new/topic/data/models/enum/interview_topic_category.enum.dart';
import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_category_model.dart';
import 'package:techtalk/features/interview_new/topic/data/models/interview_topic_model.dart';

class InterviewTopicLocalDataSourceImpl
    implements InterviewTopicLocalDataSource {
  @override
  FutureOr<List<InterviewTopicCategoryModel>> getTopicCategories() {
    return [
      ...InterviewTopicCategoryData.values.map(
        (e) => InterviewTopicCategoryModel(
          id: e.id,
          text: e.text,
        ),
      ),
    ];
  }

  @override
  FutureOr<List<InterviewTopicModel>> getTopics() {
    return [
      ...InterviewTopicData.values.map(
        (e) => InterviewTopicModel(
          id: e.id,
          text: e.text,
          category: InterviewTopicCategoryModel(
            id: e.category.id,
            text: e.category.text,
          ),
          isAvailable: e.isAvailable,
        ),
      ),
    ];
  }
}
