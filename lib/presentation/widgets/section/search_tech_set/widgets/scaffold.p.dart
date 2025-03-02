part of '../search_tech_set_page.dart';

class _Scaffold extends HookConsumerWidget {
  const _Scaffold({
    super.key,
    required this.leadingView,
    required this.searchBar,
    required this.tabBar,
    required this.searchSkillListView,
    required this.jobGroupSelectionListView,
    required this.bottomFixedBtn,
  });

  final Widget leadingView;
  final Widget searchBar;
  final Widget tabBar;
  final Widget searchSkillListView;
  final Widget jobGroupSelectionListView;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: TechSetType.values.length);

    return ControllerHolder<TabController>(
      controller: tabController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leadingView,
          const Gap(24),
          searchBar,
          const Gap(12),
          tabBar,
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                searchSkillListView,
                jobGroupSelectionListView,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
