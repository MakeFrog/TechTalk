part of 'sign_up_event.dart';

extension SkillStepEvent on SignUpEvent {
  ///
  /// 스킬 검색 유효성 검사
  ///
  String? skillInputValidation(WidgetRef ref,
          {required String? searchedTerm}) =>
      ref
          .read(skillTextFieldControllerProvider.notifier)
          .skillInputValidation(searchedTerm);

  ///
  /// 검색된 스킬 리스트 호출
  /// TextField 값 업데이트
  ///
  void onSkillFiledChanged(WidgetRef ref, {required String searchedTerm}) {
    ref.read(searchedSkillsProvider.notifier).updateSearchedList(searchedTerm);
  }

  ///
  /// 선택된 스킬에 추가
  ///
  void onSearchedSkillTapped(WidgetRef ref,
      {required SkillEntity targetSkill}) {
    ref.read(searchedSkillsProvider.notifier).clear();
    ref.read(skillTextFieldControllerProvider).clear();
    ref
        .read(selectedSkillsProvider.notifier)
        .add(targetSkill, ref.read(selectedSkillScrollControllerProvider));
  }

  ///
  /// 선택된 스킬 제거
  ///
  void onSkillChipTapped(WidgetRef ref, {required int index}) {
    ref.read(selectedSkillsProvider.notifier).removeAt(index);
    ref.read(searchedSkillsProvider.notifier).clear();
  }

  ///
  /// 필드값이 clear 되었을 때
  ///
  void onSkillFieldClear(WidgetRef ref) {
    ref.read(searchedSkillsProvider.notifier).clear();
    ref.read(skillTextFieldControllerProvider).clear();
  }

  ///
  /// 검색된 리스트 뷰를 드래그 할 때
  ///
  void onSearchedListViewDrag(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
