import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SelectQuestionCountRouteArg {
  final StartInterviewFlowBaseParam? useCaseParam;
  final InterviewType interviewType;
  final List<TopicEntity> topics;

  const SelectQuestionCountRouteArg({
    this.useCaseParam,
    required this.interviewType,
    required this.topics,
  });
}
