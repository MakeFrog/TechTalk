part of '../search_tech_set_page.dart';

class _SearchedSkillListView extends HookConsumerWidget
    with SearchTechSetState {
  const _SearchedSkillListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedKeyword =
        useListenableSelector(textEditingController(ref), () {
      return textEditingController(ref).text;
    });

    return AnimatedSizeAndFade(
      fadeDuration: const Duration(milliseconds: 240),
      child: searchedKeyword.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchedSkillListView(
                items: searchedSkills(ref),
                searchedTerm: searchedKeyword,
                onItemTapped: (_) {},
              ),
            )
          : const Text(
              '추천 검색어',
            ),
    );
  }
}
