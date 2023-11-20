import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/study/topic_select/providers/topic_list_provider.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
class SelectedStudyTopic extends _$SelectedStudyTopic {
  static String? topicName;

  @override
  InterviewTopic build() {
    final topicList = ref.read(studyTopicListProvider).requireValue.values;
    InterviewTopic? topic;
    for (final topics in topicList) {
      final findTopic = topics.firstWhereOrNull(
        (element) => element.name == topicName,
      );

      if (findTopic != null) {
        topic = findTopic;
        break;
      }
    }

    if (topic == null) {
      throw UnimplementedError;
    }

    return topic;
  }
}
