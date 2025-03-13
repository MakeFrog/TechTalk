import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';

final class TechSelectionBottomSheetResourceNotifier extends ChangeNotifier {
  final SheetController sheetController = SheetController();
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ///
  /// 선택된 스킬 및 직군
  ///
  List<TechSetEntity> selectedTechSets = [];

  ///
  /// 테크셋 추가
  ///
  void addTechSets(TechSetEntity techSet) {
    if (selectedTechSets.firstWhereOrNull((e) => e.id() == techSet.id()) !=
        null) {
      return;
    }

    final targetList = selectedTechSets.toList();

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
    targetList.removeWhere((e) => e.id() == techSet.id());
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
  void toggleTechSetSelection(TechSetType type) {
    if (type == selectedType) {
      return;
    }

    selectedType = type;
    notifyListeners();
  }

  void onDispose() {
    sheetController.dispose();
    textEditingController.dispose();
    scrollController.dispose();
  }
}

final techSelectionBottomSheetResourceProvider =
    AutoDisposeChangeNotifierProvider((ref) {
  final notifier = TechSelectionBottomSheetResourceNotifier();
  ref.onDispose(notifier.onDispose);

  return notifier;
});
