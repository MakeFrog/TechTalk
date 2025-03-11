part of '../search_tech_set_page.dart';

class _Scaffold extends HookConsumerWidget {
  const _Scaffold({
    super.key,
    required this.leadingView,
    required this.searchBar,
    required this.techSetSelectionBottomSheet,
    required this.tabBar,
    required this.searchSkillListView,
    required this.jobGroupSelectionListView,
    required this.bottomFixedBtn,
  });

  final Widget leadingView;
  final Widget searchBar;
  final Widget techSetSelectionBottomSheet;
  final Widget tabBar;
  final Widget searchSkillListView;
  final Widget jobGroupSelectionListView;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonAppBar(),
            leadingView,
            const Gap(24),
            searchBar,
            const Gap(12),
          ],
        ),
        techSetSelectionBottomSheet,
        // ScrollableSheet(
        //   // maxPosition: const SheetAnchor.proportional(772 / 812),
        //   // minPosition: const SheetAnchor.proportional(665 / 812),
        //   child: Container(
        //     height: 400,
        //     width: double.infinity,
        //     color: Colors.red,
        //     child: const Text(
        //       'data',
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
