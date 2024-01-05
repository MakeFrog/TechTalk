import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class QuestionCountSelectEvent {
  Future<void> routeToChatPage(
    WidgetRef ref, {
    required InterviewType type,
    required List<TopicEntity> topics,
    required int questionCount,
  }) async {
    // 페이지 이동 및 채팅방 정보 조회 후 제거한다.
    await EasyLoading.show();

    final room = ChatRoomEntity.random(
      type: type,
      topics: topics,
      questionCount: questionCount,
    );

    ChatPageRoute(room).go(ref.context);

    await EasyLoading.dismiss();
  }
}
