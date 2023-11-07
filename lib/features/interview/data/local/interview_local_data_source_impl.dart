import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  @override
  List<InterviewTopic> getTopics() {
    return InterviewTopic.values;
  }
}
