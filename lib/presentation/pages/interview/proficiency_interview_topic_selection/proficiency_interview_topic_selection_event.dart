import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/features/interview/use_case/start_interview_flow_use_case.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/provider/proficiency_interview_topic_selection_route_arg_provide.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/provider/selected_tech_sets_provider.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/bottom_sheet_intent.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/tech_set_selection_bottom_sheet.dart';

mixin class ProficiencyInterviewTopicSelectionEvent {
  ///
  /// 검색바가 탭 되었을 때 -> 테크셋 선택 바텀시트 노출 -> 바텀시트에서 선택된 리스트 반환 업데이트
  ///
  Future<void> onSearchBarTapped(WidgetRef ref) async {
    final prevTechSets = ref.read(selectedTechSetsProvider);
    List<TechSetEntity>? selectedTechSets =
        await BottomSheetIntent.showScrollableModalSheet<List<TechSetEntity>?>(
      ref.context,
      scrollableSheet: TechSetSelectionBottomSheet(techSets: prevTechSets),
    );

    if (selectedTechSets == null || selectedTechSets.isEmpty) {
      return;
    }

    ref.read(selectedTechSetsProvider.notifier).addList(selectedTechSets);
  }

  ///
  /// 선택된 테크셋 항목 제거
  ///
  void removeTechSetItemFromSelection(WidgetRef ref,
      {required TechSetEntity techSet}) {
    ref.read(selectedTechSetsProvider.notifier).remove(techSet);
  }

  ///
  /// 선택된 테크셋 항목 추가
  ///
  void addTechToSelection(WidgetRef ref,
      {required TechSetEntity techSet,
      required ScrollController scrollController}) {
    final itemAdded =
        ref.read(selectedTechSetsProvider.notifier).addItem(techSet);
    if (itemAdded) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 260),
            curve: Curves.fastOutSlowIn,
          );
        },
      );
    }
  }

  ///
  /// '다음' 버튼이 클릭 되었을 때 -> 면접 질문 난이도 선택 페이지
  ///
  void onConfirmBtnTapped(WidgetRef ref) {
    final arg = ref.read(proficiencyInterviewTopicSelectionRouteArgProvider);
    final selectedTopics = ref.read(selectedTechSetsProvider);

    switch (arg.useCaseParam) {
      case ProficiencyInterviewFlowParam():
        final targetParam = arg.useCaseParam as ProficiencyInterviewFlowParam;
        if (targetParam.topicSelectionCompleter.isCompleted) {
          final param = targetParam.copyWith(
              topicSelectionCompleter: Completer()..complete(selectedTopics));
          StartInterviewFlowUseCase(param).proficiencyInterview();
        } else {
          targetParam.topicSelectionCompleter.complete(selectedTopics);
        }
    }
  }
}
