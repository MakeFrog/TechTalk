import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
class SelectedStudyTopic extends _$SelectedStudyTopic {
  @override
  InterviewTopicEntity build() {
    throw UnimplementedError;
  }

  set topic(InterviewTopicEntity value) => state = value;
}
