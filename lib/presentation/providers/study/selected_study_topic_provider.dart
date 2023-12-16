import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/study/categorized_study_topics_provider.dart';

part 'selected_study_topic_provider.g.dart';

@Riverpod(
  keepAlive: true,
)
class SelectedStudyTopic extends _$SelectedStudyTopic {
  @override
  Topic? build() {
    return null;
  }

  void update(Topic value) {
    final topicList =
        ref.read(categorizedStudyTopicsProvider).requireValue.values;
    Topic? topic;

    for (final topics in topicList) {
      final findTopic = topics.firstWhereOrNull(
        (element) => element.id == value.id,
      );

      if (findTopic != null) {
        topic = findTopic;
        break;
      }
    }
    state = topic;
  }
}
