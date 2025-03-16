import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SelectQuestionCountRouteArg {
  final InterviewType interviewType;
  final List<TopicEntity> topics;

  const SelectQuestionCountRouteArg({
    required this.interviewType,
    required this.topics,
  });
}
