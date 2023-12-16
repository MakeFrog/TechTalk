import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

part 'selected_topic_provider.g.dart';

@riverpod
class SelectedTopic extends _$SelectedTopic {
  @override
  TopicEntity? build() {
    return null;
  }

  ///
  /// 면접 주제가 선택되었을 때
  ///
  void onTopicSelected(TopicEntity passedTopic) {
    final isSelected = passedTopic == state;

    if (isSelected) {
      state = null;
    } else {
      state = passedTopic;
    }
  }
}
