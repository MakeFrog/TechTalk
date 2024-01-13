import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/interview_rooms_provider.dart';

mixin class HomeEvent {
  void onTapPracticalInterview(WidgetRef ref) async {
    final chatRooms =
        await ref.read(interviewRoomsProvider(InterviewType.practical).future);

    if (chatRooms.isEmpty) {
      const InterviewTopicSelectRoute(InterviewType.practical)
          .push(ref.context);
    } else {
      ChatListPageRoute(InterviewType.practical).push(ref.context);
    }
  }

  void onTapNewTopicInterview() {
    const InterviewTopicSelectRoute(InterviewType.topic)
        .push(rootNavigatorKey.currentContext!);
  }

  Future<void> onTapGoToInterviewRoomListPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) async {
    final chatRooms = await ref
        .read(interviewRoomsProvider(InterviewType.topic, topic.id).future);
    if (chatRooms.isEmpty) {
      QuestionCountSelectPageRoute(
        InterviewType.topic,
        $extra: [topic],
      ).push(ref.context);
    } else {
      ChatListPageRoute(InterviewType.topic, topicId: topic.id)
          .push(rootNavigatorKey.currentContext!);
    }
  }
}
