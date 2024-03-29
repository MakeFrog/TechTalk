import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

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
