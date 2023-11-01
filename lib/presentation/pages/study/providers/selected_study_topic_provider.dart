import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/pages/main/tab_views/study/providers/topic_list_provider.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
class SelectedStudyTopic extends _$SelectedStudyTopic {
  static String? topicName;

  @override
  InterviewTopicEntity? build() {
    final topicList = ref.read(topicListProvider).requireValue.values;
    InterviewTopicEntity? topic;
    for (final topics in topicList) {
      final findTopic = topics.firstWhereOrNull(
        (element) => element.name == topicName,
      );

      if (findTopic != null) {
        topic = findTopic;
        break;
      }
    }

    return topic;
  }
}
