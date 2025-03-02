import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'level_selection_page_view_controller.g.dart';

@riverpod
class LevelSelectionPageViewController
    extends _$LevelSelectionPageViewController {
  @override
  Raw<PageController> build() {
    final controller = PageController();
    ref.onDispose(controller.dispose);
    return controller;
  }
}
