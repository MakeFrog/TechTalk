import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/providers/study/categorized_study_topics_provider.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
String selectedStudyTopicId(SelectedStudyTopicIdRef ref) {
  throw UnimplementedError();
}

@Riverpod(
  dependencies: [
    selectedStudyTopicId,
  ],
)
class SelectedStudyTopic extends _$SelectedStudyTopic {
  @override
  InterviewTopic build() {
    final topicId = ref.watch(selectedStudyTopicIdProvider);
    final topicList =
        ref.read(categorizedStudyTopicsProvider).requireValue.values;
    InterviewTopic? topic;
    for (final topics in topicList) {
      final findTopic = topics.firstWhereOrNull(
        (element) => element.id == topicId,
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
