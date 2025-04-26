part of '../tech_set_selection_bottom_sheet.dart';

class _SkillPageView extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const _SkillPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,

            // Sticky Header 배경색 유지
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TechtalkTextField(
                useCustomValidation: true,
                showPrefixIcon: true,
                inputDecoration: InputDecoration(
                  hintText: tr(LocaleKeys.interview_proficiency_search_hint),
                ),
                controller: textEditingController(ref),
                validator: (input) => skillInputValidator(ref, input: input),
                onClear: () {
                  onSearchBarClearBtnTapped(ref);
                },
                onChanged: (searchedTerm) {
                  onFieldChanged(ref, searchedTerm: searchedTerm);
                },
              ),
            ),
          ),
          const _SearchedSkillListView(),
        ],
      ),
    );
  }
}
