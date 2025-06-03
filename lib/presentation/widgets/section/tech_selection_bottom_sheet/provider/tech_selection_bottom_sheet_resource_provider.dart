import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/repositories/enums/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/provider/tech_set_selection_bottom_sheet_route_arg_provider.dart';

final class TechSelectionBottomSheetResourceNotifier extends ChangeNotifier {
  TechSelectionBottomSheetResourceNotifier(this.selectedTechSets);

  ///
  /// 선택된 스킬 및 직군
  ///
  List<TechSetEntity> selectedTechSets;

  /// 각종 컨트롤러
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final PageController pageViewController = PageController();

  ///
  /// 테크셋 추가
  ///
  void toggleTechSets(TechSetEntity techSet) {
    final targetList = selectedTechSets.toList();

    if (selectedTechSets.firstWhereOrNull((e) => e == techSet) != null) {
      if (techSet is JobGroupEntity) {
        removeSelection(techSet);
      }
      return;
    }

    if (selectedTechSets.length >= 4) {
      DialogService.show(
        dialog: AppDialog.singleBtn(
          showContentImg: false,
          title: '개수 제한',
          description: '최대 4개까지 선택할 수 있어요',
          btnContent: '확인',
          onBtnClicked: () async {
            (await navigationContext).pop();
          },
        ),
      );
      return;
    }

    targetList.add(techSet);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 260),
          curve: Curves.fastOutSlowIn,
        );
      },
    );

    selectedTechSets = targetList;
    notifyListeners();
  }

  ///
  /// 스킬 및 직군 선택 해제
  ///
  void removeSelection(TechSetEntity techSet) {
    final targetList = selectedTechSets.toList();
    targetList.removeWhere((e) => e == techSet);
    selectedTechSets = targetList;
    notifyListeners();
  }

  ///
  /// 선택된 테크셋 유형
  ///
  TechSetType selectedType = TechSetType.skill;

  ///
  /// 테크셋 유형 선택여부 토글
  ///
  Future<void> toggleTechSetSelection(TechSetType type) async {
    if (type.index == pageViewController.page?.floor()) {
      return;
    }

    await pageViewController.animateToPage(type.index,
        duration: const Duration(milliseconds: 320), curve: Curves.easeInOut);
  }

  void onDispose() {
    textEditingController.dispose();
    scrollController.dispose();
    pageViewController.dispose();
  }
}

final techSelectionBottomSheetResourceProvider =
    AutoDisposeChangeNotifierProvider(
  (ref) {
    final passedTechSetsSelection =
        ref.read(techSetSelectionBottomSheetRouteArgProvider);
    final notifier =
        TechSelectionBottomSheetResourceNotifier(passedTechSetsSelection);

    ref.onDispose(notifier.onDispose);

    return notifier;
  },
  dependencies: [techSetSelectionBottomSheetRouteArgProvider],
);
