part of '../tech_set_selection_bottom_sheet.dart';

class _SearchedSkillListView extends HookConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const _SearchedSkillListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedKeyword =
        useListenableSelector(textEditingController(ref), () {
      return textEditingController(ref).text;
    });

    return SearchedSkillListView(
      padding: EdgeInsets.only(bottom: AppSize.ratioHeight(520), top: 8) +
          const EdgeInsets.symmetric(horizontal: 16),
      scrollPhysics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      hideKeyboardOnScroll: false,
      items: searchedSkills(ref),
      searchedTerm: searchedKeyword,
      onItemTapped: (skill) {
        onSearchedSkillTapped(ref, targetSkill: skill);
      },
    );
  }
}
