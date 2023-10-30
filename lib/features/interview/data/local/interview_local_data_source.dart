import 'package:techtalk/features/interview/data/models/interview_topic_model.dart';

abstract interface class InterviewLocalDataSource {
  List<InterviewTopicModel> getInterviewTopicList();
}
