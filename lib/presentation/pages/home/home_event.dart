import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/interview_rooms_provider.dart';

mixin class HomeEvent {
  void onTapPracticalInterview() {
    // TODO: implement onTapPracticalInterview
  }

  void onTapNewTopicInterview() {
    const InterviewTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }

  void onTapGoToInterviewRoomListPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) async {
    final chatRooms = await ref.read(interviewRoomsProvider(topic.id).future);
    if (chatRooms.isEmpty) {
      QuestionCountSelectPageRoute($extra: topic).push(ref.context);
    } else {
      ChatListPageRoute(topic.id).push(rootNavigatorKey.currentContext!);
    }
  }
}
