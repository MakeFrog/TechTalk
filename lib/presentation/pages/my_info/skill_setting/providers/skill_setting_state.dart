import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/skill_input_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

mixin class SkillSettingState {
  ///
  /// 검색된 스킬 리스트
  ///
  List<SkillEntity> skills(WidgetRef ref) => ref.watch(searchedSkillsProvider);

  ///
  /// 검색어
  ///
  String searchedTerm(WidgetRef ref) => ref.watch(skillInputProvider);

  ///
  /// 저장하기 버튼 활성화 여부
  ///
  bool isBottomFixedBtnActivate(WidgetRef ref) {
    final selectedSkills = ref.read(selectedSkillsProvider);

    if (selectedSkills.isEmpty) {
      return false;
    }

    final userSkills = ref.read(userDataProvider).value!.skills;

    return !selectedSkills.isElementEquals(userSkills);
  }
}
