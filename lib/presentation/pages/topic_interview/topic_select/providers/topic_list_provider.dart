import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'topic_list_provider.g.dart';

@riverpod
Future<List<InterviewTopicEntity>> topicList(TopicListRef ref) async {
  final getInterviewTopicListUseCase = GetIt.I<GetInterviewTopicListUseCase>();

  return getInterviewTopicListUseCase();
}
