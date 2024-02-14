import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'selected_wrong_answer_topic_provider.g.dart';

@riverpod
class SelectedWrongAnswerTopic extends _$SelectedWrongAnswerTopic {
  @override
  TopicEntity? build() {
    final targetTopics =
        ref.watch(userInfoProvider).requireValue?.targetedTopics;

    return targetTopics?.first;
  }

  void updateTopic(TopicEntity value) => state = value;
}
