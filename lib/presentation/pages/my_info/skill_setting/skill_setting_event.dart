import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/providers/input/skill_text_field_controller_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class SkillSettingEvent {
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
  /// 닉네임필드에 값이 clear 되었을 때
  ///
  void onSkillFieldClear(WidgetRef ref) {
    ref.read(skillTextFieldControllerProvider).clear();
    ref.read(searchedSkillsProvider.notifier).clear();
  }

  ///
  /// 선택된 스킬에 추가
  ///
  void onSearchedSkillTapped(WidgetRef ref,
      {required SkillEntity targetSkill}) {
    ref.read(skillTextFieldControllerProvider).clear();
    ref.read(searchedSkillsProvider.notifier).clear();
    ref.read(selectedSkillsProvider.notifier).add(targetSkill);
  }

  ///
  /// 스킬 검색 유효성 검사
  ///
  String? skillInputValidation(WidgetRef ref,
          {required String? searchedTerm}) =>
      ref
          .read(skillTextFieldControllerProvider.notifier)
          .skillInputValidation(searchedTerm);

  ///
  /// 변경된 직군 정보 저장
  ///
  void onSaveBtnTapped(WidgetRef ref) {
    EasyLoading.show();
    final selectedSkills = ref.watch(selectedSkillsProvider);
    final user =
        ref.read(userInfoProvider).value!.copyWith(skills: selectedSkills);
    ref.read(userInfoProvider.notifier).updateData(user).whenComplete(() {
      EasyLoading.dismiss();
      ref.context.pop();
      SnackBarService.showSnackBar('스킬 정보가 변경되었습니다');
    });
  }
}
