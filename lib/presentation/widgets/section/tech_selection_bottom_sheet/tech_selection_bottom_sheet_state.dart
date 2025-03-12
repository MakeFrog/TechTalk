import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/core/modules/regex/app_validator.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/provider/tech_selection_bottom_sheet_resource_provider.dart';

mixin class TechSelectionBottomSheetState {
  ///
  /// 스킬 검색 유효성
  ///
  String? skillInputValidator(WidgetRef ref, {required String? input}) =>
      AppValidator.skillInputValidation(
        input: input,
        isResultEmpty: searchedSkills(ref).isEmpty,
      );

  ///
  /// 검색된 스킬 리스트
  ///
  List<SkillEntity> searchedSkills(WidgetRef ref) =>
      ref.watch(searchedSkillsProvider);

  ///
  /// TextEditing 컨트롤러
  ///
  TextEditingController textEditingController(WidgetRef ref) =>
      ref.watch(techSelectionBottomSheetResourceProvider
          .select((p) => p.textEditingController));

  ///
  /// 선택된 테크셋 유형
  ///
  TechSetType selectedTechSetType(WidgetRef ref) => ref.watch(
      techSelectionBottomSheetResourceProvider.select((p) => p.selectedType));

  ///
  /// 바텀시트 컨트롤러
  ///
  SheetController sheetController(WidgetRef ref) =>
      ref.watch(techSelectionBottomSheetResourceProvider
          .select((p) => p.sheetController));
}
