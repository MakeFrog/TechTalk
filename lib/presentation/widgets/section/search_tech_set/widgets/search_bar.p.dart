part of '../search_tech_set_page.dart';

class _SearchBar extends ConsumerWidget
    with SearchTechSetState, SearchTechSetEvent {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TechtalkTextField(
          inputDecoration: const InputDecoration(
            hintText: '스킬 및 직군을 검색해 주세요',
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
    );
  }
}
