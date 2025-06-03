part of '../tech_set_selection_bottom_sheet.dart';

class _SelectedTechSetListView extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const _SelectedTechSetListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TechSetListView(
      techSets: selectedTechSets(ref),
      scrollController: scrollController(ref),
      onItemTapped: (item) {
        onSelectedTechSetTapped(ref, techSet: item);
      },
    );
  }
}
