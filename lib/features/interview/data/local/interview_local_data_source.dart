import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';

abstract interface class InterviewLocalDataSource {
  List<InterviewTopic> getTopics();
}
