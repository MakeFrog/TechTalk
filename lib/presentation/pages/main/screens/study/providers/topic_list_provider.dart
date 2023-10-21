import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'topic_list_provider.g.dart';

@riverpod
Future<Map<String, List<InterviewTopicEntity>>> topicList(
  TopicListRef ref,
) async {
  final getInterviewTopicListUseCase = GetIt.I<GetInterviewTopicListUseCase>();

  final topicList = await getInterviewTopicListUseCase();
  topicList.sort(
    (a, b) => a.category.compareTo(b.category),
  );

  final resolvedTopicList = <String, List<InterviewTopicEntity>>{};

  for (final topic in topicList) {
    if (resolvedTopicList.containsKey(topic.category)) {
      resolvedTopicList[topic.category]!.add(topic);
    } else {
      resolvedTopicList[topic.category] = [topic];
    }
  }

  return resolvedTopicList;
}
