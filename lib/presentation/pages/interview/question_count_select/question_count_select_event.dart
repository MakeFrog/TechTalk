import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_question_count_provider.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_room_provider.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_topic_provider.dart';

abstract class _QuestionCountSelectEvent {
  Future<void> routeToChatPage(WidgetRef ref);
}

mixin class QuestionCountSelectEvent implements _QuestionCountSelectEvent {
  @override
  Future<void> routeToChatPage(WidgetRef ref) async {
    // 페이지 이동 및 채팅방 정보 조회 후 제거한다.
    await EasyLoading.show();

    final roomId = await createInterviewRoomUseCase(
      topicId: ref.read(selectedInterviewTopicProvider)!.id,
      questionCount: ref.read(selectedInterviewQuestionCountProvider),
    );
    await ref
        .read(selectedInterviewRoomProvider.notifier)
        .update(roomId.getOrThrow())
        .then((value) {
      ChatPageRoute(
        ref.read(selectedInterviewTopicProvider)!.id,
        roomId.getOrThrow(),
      ).go(ref.context);
    });

    await EasyLoading.dismiss();
  }
}
