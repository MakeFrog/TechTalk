part of '../proficiency_interview_topic_selection_page.dart';

class _SelectedTechSetListView extends ConsumerWidget
    with SearchTechSetState, SearchTechSetEvent {
  const _SelectedTechSetListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TechSetListView(
      techSets: selectedTechSets(ref),
      height: 60,
      scrollController: context.getController<ScrollController>(),
      onItemTapped: (item) {
        removeTechSetItemFromSelection(ref, techSet: item);
      },
    );
  }
}
