import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/provider/tech_selection_bottom_sheet_resource_provider.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/tech_selection_bottom_sheet_state.dart';

import '../search_tech_set/constant/tech_set_type.enum.dart';

mixin class TechSelectionBottomSheetEvent {
  ///
  /// '스킬' or '직군' 선택 활성화 버튼이 클릭 되었을 때
  ///
  void onTechSelectionTapped(WidgetRef ref, {required TechSetType type}) {
    ref.read(
      techSelectionBottomSheetResourceProvider.notifier.select(
        (p) => p.toggleTechSetSelection(type),
      ),
    );
  }

  ///
  /// 선택된 '스킬' or '직군' 클릭 되었을 때
  /// => 선택 해제
  ///
  void onSelectedTechSetTapped(WidgetRef ref,
      {required TechSetEntity techSet}) {
    ref.read(
      techSelectionBottomSheetResourceProvider.notifier.select(
        (p) => p.removeSelection(techSet),
      ),
    );
  }

  ///
  /// 검색된 스킬 리스트 호출
  /// TextField 값 업데이트
  ///
  void onFieldChanged(WidgetRef ref, {required String searchedTerm}) {
    ref.read(searchedSkillsProvider.notifier).updateSearchedList(searchedTerm);
  }

  ///
  /// 선택된 스킬 제거
  ///
  void onSelectableChipTapped(WidgetRef ref, {required int index}) {
    ref.read(selectedSkillsProvider.notifier).removeAt(index);
  }

  ///
  /// 검색바 'x' 버튼이 클릭 되었을 때
  ///
  void onSearchBarClearBtnTapped(WidgetRef ref) {
    final textEditingController =
        TechSelectionBottomSheetState().textEditingController(ref);
    textEditingController.text = '';
  }

  ///
  /// 검색된 스킬 리스트 아이템 항목이 탭 되었을 때
  ///
  void onSkillItemTapped(WidgetRef ref, {required SkillEntity skillItem}) {
    onSearchBarClearBtnTapped(ref);
    ref.read(searchedSkillsProvider.notifier).clear();
    ref.read(techSelectionBottomSheetResourceProvider
        .select((p) => p.toggleTechSets(TechSetEntity.skill(skillItem))));
  }

  ///
  /// 직군 리스트 아이템 항목이 탭 되었을 때
  ///

  void onJobGroupItemTapped(WidgetRef ref,
      {required JobGroupEntity jobGroupItem}) {
    ref.read(techSelectionBottomSheetResourceProvider
        .select((p) => p.toggleTechSets(TechSetEntity.jobGroup(jobGroupItem))));
  }
}
