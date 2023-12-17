import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'selected_study_topic_provider.g.dart';

@riverpod
class SelectedStudyTopic extends _$SelectedStudyTopic {
  @override
  Topic? build() => null;

  void update(Topic value) => state = value;
}
