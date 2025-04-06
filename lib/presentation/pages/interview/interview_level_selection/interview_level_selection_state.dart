import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/provider/level_selection_page_view_controller.dart';

mixin class InterviewLevelSelectionState {
  ///
  /// 페이지뷰 컨트롤러
  ///
  PageController pageController(WidgetRef ref) =>
      ref.watch(levelSelectionPageViewControllerProvider);
}
