part of '../tech_set_selection_bottom_sheet.dart';

class _SearchedSkillListView extends HookConsumerWidget
    with TechSelectionBottomSheetState {
  const _SearchedSkillListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return GestureDetector(
    //   child: ListView.builder(
    //       physics: const NeverScrollableScrollPhysics(),
    //       itemCount: 100,
    //       shrinkWrap: true,
    //       padding: EdgeInsets.only(top: 8),
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Text(index.toString()),
    //         );
    //       }),
    // );
    final searchedKeyword =
        useListenableSelector(textEditingController(ref), () {
      return textEditingController(ref).text;
    });

    return SearchedSkillListView(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      hideKeyboardOnScroll: false,
      items: searchedSkills(ref),
      searchedTerm: searchedKeyword,
      onItemTapped: (_) {},
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      child: searchedKeyword.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16) +
                  const EdgeInsets.only(bottom: 200),
              child: SearchedSkillListView(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                items: searchedSkills(ref),
                searchedTerm: searchedKeyword,
                onItemTapped: (_) {},
              ),
            )
          : const EmptyBox(),
    );
  }
}
