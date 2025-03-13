part of '../tech_set_selection_bottom_sheet.dart';

class _SelectedSkillListView extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const _SelectedSkillListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSizeAndFade(
      sizeDuration: const Duration(milliseconds: 320),
      fadeDuration: const Duration(milliseconds: 326),
      child: selectedTechSets(ref).isNotEmpty
          ? SizedBox(
              height: 56,
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListView.separated(
                    controller: scrollController(ref),
                    padding: const EdgeInsets.only(left: 16, right: 24),
                    itemCount: selectedTechSets(ref).length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const Gap(8),
                    itemBuilder: (context, index) {
                      final techSet = selectedTechSets(ref)[index];
                      return Center(
                        child: techSet.fold(skill: (skill) {
                          return ClosableFilledChip(
                            logoPath: skill.imagePath,
                            name: skill.name,
                            onTap: () {
                              onSelectedTechSetTapped(ref, techSet: techSet);
                            },
                          );
                        }, jobGroup: (jobGroup) {
                          return Align(
                            alignment: Alignment.topCenter,
                            child: ClosableFilledChip(
                              name: jobGroup.name,
                              onTap: () {
                                onSelectedTechSetTapped(ref, techSet: techSet);
                              },
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            )
          : const EmptyBox(),
    );
  }
}
