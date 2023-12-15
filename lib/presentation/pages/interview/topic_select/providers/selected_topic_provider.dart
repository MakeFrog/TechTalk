import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'selected_topic_provider.g.dart';

@riverpod
class SelectedTopic extends _$SelectedTopic {
  @override
  Topic? build() {
    return null;
  }

  ///
  /// 면접 주제가 선택되었을 때
  ///
  void onTopicSelected(Topic passedTopic) {
    final isSelected = passedTopic == state;

    if (isSelected) {
      state = null;
    } else {
      state = passedTopic;
    }
  }
}
