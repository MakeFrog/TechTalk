import 'package:techtalk/features/chat/chat.dart';

abstract interface class InterviewLocalDataSource {
  List<InterviewTopic> getTopics();
}
