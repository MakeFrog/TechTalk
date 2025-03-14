part of '../tech_set_selection_bottom_sheet.dart';

class _JobGroupPageView extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const _JobGroupPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 160),
      itemCount: totalJobGroups.length,
      itemBuilder: (context, index) {
        final jobGroup = totalJobGroups[index];
        final isSelected = selectedTechSets(ref)
                .firstWhereOrNull((e) => e.id() == jobGroup.id) !=
            null;

        return JobGroupListTile(
          item: jobGroup,
          isSelected: isSelected,
          onItemTapped: (item) {
            onJobGroupItemTapped(ref, jobGroupItem: item);
          },
        );
      },
    );
  }
}
