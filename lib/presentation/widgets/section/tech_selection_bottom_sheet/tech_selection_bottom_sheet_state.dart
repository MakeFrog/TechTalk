import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/modules/regex/app_validator.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/features/tech_set/repositories/enums/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/provider/tech_selection_bottom_sheet_resource_provider.dart';

mixin class TechSelectionBottomSheetState {
  ///
  /// 선택된 스킬 및 직군
  ///
  List<TechSetEntity> selectedTechSets(WidgetRef ref) =>
      ref.watch(techSelectionBottomSheetResourceProvider
          .select((p) => p.selectedTechSets));

  ///
  /// 전체 개발 직군 리스트
  ///
  List<JobGroupEntity> get totalJobGroups {
    return techSetRepository.getJobs(); // <-- 캐싱된 값에 접근하고 있음. 호출 API X
  }

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
  /// 페이지뷰 컨트롤러 스킬 <-> 직군
  ///
  PageController pageController(WidgetRef ref) =>
      ref.watch(techSelectionBottomSheetResourceProvider
          .select((p) => p.pageViewController));

  ///
  /// 선택된 스킬 리스트뷰 > 스크롤 컨트롤러
  ///
  ScrollController scrollController(WidgetRef ref) => ref.read(
        techSelectionBottomSheetResourceProvider.select(
          (p) => p.scrollController,
        ),
      );
}
