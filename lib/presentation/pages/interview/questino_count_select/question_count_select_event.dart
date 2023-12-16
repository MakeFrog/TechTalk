import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_progress_state.enum.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';
import 'package:techtalk/presentation/pages/interview/questino_count_select/provider/question_count_select_page_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/questino_count_select/provider/selected_question_count_provider.dart';

abstract class _QuestionCountSelectEvent {
  void routeToChatPage(WidgetRef ref);
}

mixin class QuestionCountSelectedEvent implements _QuestionCountSelectEvent {
  @override
  void routeToChatPage(WidgetRef ref) {
    final aim = InterviewerAvatar.getRandomInterviewer();
    ChatPageRoute(
      progressState: InterviewProgressState.initial,
      roomId: StringGenerator.generateRandomString(),
      $extra: (
        qnaProgressInfo: ChatQnaProgressInfoEntity.onInitial(
          totalQuestionCount: ref.watch(selectedQuestionCountProvider),
        ),
        topic: ref.read(questionCountSelectRouteArgProvider),
      ),
      interviewer: aim,
    ).go(rootNavigatorKey.currentContext!);

    print('선택된 캐릭터 : ${aim.id}');
  }
}
