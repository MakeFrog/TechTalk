import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_job_group_scroll_controller.g.dart';

@riverpod
Raw<ScrollController> selectedJobGroupScrollController(
    SelectedJobGroupScrollControllerRef ref) {
  return ScrollController();
}
