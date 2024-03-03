import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

part 'select_question_count_route_arg.g.dart';

@riverpod
SelectQuestionCountRouteArg selectedQuestionCountRouteArg(
    SelectedQuestionCountRouteArgRef ref) {
  return QuestionCountSelectPageRoute.arg;
}

typedef SelectQuestionCountRouteArg = ({
  InterviewType type,
  List<TopicEntity> topics
});
