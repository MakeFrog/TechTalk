import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
InterviewTopic selectedStudyTopic(SelectedStudyTopicRef ref) {
  throw Exception('학습 주제 선택하지 않음');
}
