import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/topic/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/interview_topic_select_route_arg.dart';

part 'selected_interview_topics_provider.g.dart';

@Riverpod()
class SelectedInterviewTopics extends _$SelectedInterviewTopics {
  @override
  List<TopicEntity> build() {
    return [];
  }

  static const limitCount = 3;

  void toggleOrRemove(TopicEntity targetTopic) {
    final interviewTopic = ref.watch(interviewTopicSelectRouteArgProvider);

    if (state.contains(targetTopic)) {
      final removedTopics = state..remove(targetTopic);
      state = [...removedTopics];
    } else if (interviewTopic.isPractical && state.length > limitCount) {
      SnackBarService.showSnackBar('최대 4개까지 선택 가능합니다');
    } else if (interviewTopic.isSingleTopic) {
      state = [targetTopic];
    } else {
      state = [...state, targetTopic];
    }
  }
}
