import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_skill_scroll_controller.g.dart';

@riverpod
Raw<ScrollController> selectedSkillScrollController(
    SelectedSkillScrollControllerRef ref) {
  return ScrollController();
}
