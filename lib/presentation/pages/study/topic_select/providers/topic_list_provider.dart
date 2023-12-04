import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'topic_list_provider.g.dart';

@riverpod
Future<Map<String, List<InterviewTopic>>> studyTopicList(
  StudyTopicListRef ref,
) async {
  final getInterviewTopicListUseCase = locator<GetInterviewTopicsUseCase>();

  final topicList = List.of(await getInterviewTopicListUseCase());
  topicList.sort(
    (a, b) => a.category.text.compareTo(b.category.text),
  );

  final resolvedTopicList = <String, List<InterviewTopic>>{};

  for (final topic in topicList) {
    if (resolvedTopicList.containsKey(topic.category.text)) {
      resolvedTopicList[topic.category.text]!.add(topic);
    } else {
      resolvedTopicList[topic.category.text] = [topic];
    }
  }

  return resolvedTopicList;
}
