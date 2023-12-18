import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract class _QuestionCountSelectEvent {
  Future<void> routeToChatPage(
    WidgetRef ref, {
    required Topic topic,
    required int questionCount,
  });
}

mixin class QuestionCountSelectEvent implements _QuestionCountSelectEvent {
  @override
  Future<void> routeToChatPage(
    WidgetRef ref, {
    required Topic topic,
    required int questionCount,
  }) async {
    // 페이지 이동 및 채팅방 정보 조회 후 제거한다.
    await EasyLoading.show();

    final roomId = await createInterviewRoomUseCase(
      topicId: topic.id,
      questionCount: questionCount,
    );
    ChatPageRoute(
      topic.id,
      roomId.getOrThrow(),
    ).go(ref.context);

    await EasyLoading.dismiss();
  }
}
