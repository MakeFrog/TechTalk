import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/providers/input/skill_text_field_controller_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class SkillSettingState {
  ///
  /// 검색된 스킬 리스트
  ///
  List<SkillEntity> searchedSkills(WidgetRef ref) =>
      ref.watch(searchedSkillsProvider);

  ///
  /// 검색어
  ///
  String searchedTerm(WidgetRef ref) =>
      ref.watch(skillTextFieldControllerProvider).text;

  ///
  /// 선택된 스킬 리스트
  ///
  List<SkillEntity> selectedSkills(WidgetRef ref) =>
      ref.watch(selectedSkillsProvider);

  ///
  /// 저장하기 버튼 활성화 여부
  ///
  bool isBottomFixedBtnActivate(WidgetRef ref) {
    final selectedSkills = ref.watch(selectedSkillsProvider);

    if (selectedSkills.isEmpty) {
      return false;
    }

    final userSkills = ref.read(userInfoProvider).value!.skills;

    return !selectedSkills.isElementEquals(userSkills);
  }

  ///
  /// 스킬 검색 필드 컨트롤러
  ///
  TextEditingController skillTextFieldController(WidgetRef ref) =>
      ref.watch(skillTextFieldControllerProvider);
}
