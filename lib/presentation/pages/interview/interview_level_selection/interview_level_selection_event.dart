import 'package:flutter/animation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/provider/interview_level_selection_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/provider/level_selection_page_view_controller.dart';

mixin class InterviewLevelSelectionEvent {
  ///
  /// 상,중,하 레벨 버튼이 클릭 되었을 때
  ///
  void onLevelBtnTapped(WidgetRef ref, {required int index}) {
    final controller = ref.read(levelSelectionPageViewControllerProvider);
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }
}
