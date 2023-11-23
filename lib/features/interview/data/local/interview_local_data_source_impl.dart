import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  @override
  List<InterviewTopic> getTopics() {
    return InterviewTopic.values;
  }
}
