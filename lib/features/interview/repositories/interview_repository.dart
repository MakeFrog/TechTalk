import 'package:techtalk/features/interview/entities/interview_topic_entity.dart';

abstract interface class InterviewRepository {
  Future<List<InterviewTopicEntity>> getInterviewTopicList();
}
