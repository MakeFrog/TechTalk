part of '../search_tech_set_page.dart';

class _Scaffold extends HookConsumerWidget {
  const _Scaffold({
    super.key,
    required this.leadingView,
    required this.searchBar,
    required this.selectedTechSets,
    required this.recommendedTechSets,
    required this.bottomFixedBtn,
  });

  final Widget leadingView;
  final Widget searchBar;
  final Widget selectedTechSets;
  final Widget recommendedTechSets;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leadingView,
        const Gap(24),
        searchBar,
        selectedTechSets,
        recommendedTechSets,
      ],
    );
  }
}
