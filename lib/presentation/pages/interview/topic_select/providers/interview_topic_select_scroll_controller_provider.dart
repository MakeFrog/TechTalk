import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interview_topic_select_scroll_controller_provider.g.dart';

@riverpod
Raw<ScrollController> interviewTopicSelectScrollController(
    InterviewTopicSelectScrollControllerRef ref) {
  return ScrollController();
}
