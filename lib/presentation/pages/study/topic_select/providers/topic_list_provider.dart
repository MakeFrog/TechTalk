import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'topic_list_provider.g.dart';

@riverpod
Future<Map<String, List<InterviewTopic>>> studyTopicList(
  StudyTopicListRef ref,
) async {
  final getInterviewTopicListUseCase = locator<GetInterviewTopicListUseCase>();

  final response = await getInterviewTopicListUseCase();

  return response.fold(
    onSuccess: (topicList) {
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
    },
    onFailure: (e) {
      log(e.toString());
      ToastService.show(CustomToast(message: e.toString()));
      throw e;
    },
  );
}
