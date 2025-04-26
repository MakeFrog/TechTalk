import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

part 'selected_interview_topic_provider.g.dart';

@riverpod
class SelectedInterviewTopic extends _$SelectedInterviewTopic {
  @override
  TopicEntity build(TopicEntity topic) {
    return topic;
  }

  void update(TopicEntity topic) {
    if (state == topic) return;
    state = topic;
  }
}
