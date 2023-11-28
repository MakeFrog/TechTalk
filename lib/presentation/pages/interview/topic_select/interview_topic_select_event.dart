import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';

abstract class _InterviewTopicSelectEvent {
  void onTapNext(WidgetRef ref, InterviewTopic topic);
}

mixin class InterviewTopicSelectEvent implements _InterviewTopicSelectEvent {
  @override
  void onTapNext(WidgetRef ref, InterviewTopic topic) {
    // TODO: implement onTapNext
  }
}
