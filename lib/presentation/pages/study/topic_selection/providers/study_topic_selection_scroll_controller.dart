import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_topic_selection_scroll_controller.g.dart';

@riverpod
Raw<ScrollController> studyTopicSelectionScrollController(
    StudyTopicSelectionScrollControllerRef ref) {
  return ScrollController();
}
