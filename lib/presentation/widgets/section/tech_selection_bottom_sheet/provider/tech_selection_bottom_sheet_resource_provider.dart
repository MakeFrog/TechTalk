import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';

final class TechSelectionBottomSheetResourceNotifier extends ChangeNotifier {
  final SheetController sheetController = SheetController();
  final TextEditingController textEditingController = TextEditingController();

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
  }
}

final techSelectionBottomSheetResourceProvider =
    AutoDisposeChangeNotifierProvider((ref) {
  final notifier = TechSelectionBottomSheetResourceNotifier();
  ref.onDispose(notifier.onDispose);

  return notifier;
});
