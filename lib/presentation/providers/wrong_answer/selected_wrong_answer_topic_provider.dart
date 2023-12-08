import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/entities/interview_topic.enum.dart';
import 'package:techtalk/presentation/providers/user/user_interview_topics_provider.dart';

part 'selected_wrong_answer_topic_provider.g.dart';

@riverpod
class SelectedWrongAnswerTopic extends _$SelectedWrongAnswerTopic {
  @override
  InterviewTopic build() {
    final userTopics = ref.watch(userInterviewTopicsProvider).requireValue;

    return userTopics.first;
  }

  void update(InterviewTopic value) => state = value;
}
