import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'selected_interview_topic_provider.g.dart';

@riverpod
class SelectedInterviewTopic extends _$SelectedInterviewTopic {
  @override
  Topic? build() => null;

  ///
  /// 면접 주제가 선택되었을 때
  ///
  void onTopicSelected(Topic passedTopic) {
    state = passedTopic == state ? null : passedTopic;
  }
}
