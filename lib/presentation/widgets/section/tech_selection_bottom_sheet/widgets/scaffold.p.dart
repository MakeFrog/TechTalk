part of '../tech_set_selection_bottom_sheet.dart';

class _Scaffold extends ConsumerWidget with TechSelectionBottomSheetState {
  const _Scaffold({
    super.key,
    required this.headerSelectionView,
    required this.selectedTechSetListView,
    required this.skillPageView,
    required this.jobGroupView,
  });

  static SheetAnchor minProportional =
      const SheetAnchor.proportional(0.856); // 655 + 40 / 812
  static SheetAnchor maxProportional =
      const SheetAnchor.proportional(0.938); // 722 + 40 / 812;

  final Widget headerSelectionView;
  final Widget selectedTechSetListView;
  final Widget skillPageView;
  final Widget jobGroupView;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ScrollableSheet(
      maxPosition: maxProportional,
      minPosition: minProportional,
      initialPosition: minProportional,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              IgnorePointer(
                child: SheetDraggable(
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      height: 6,
                      width: 36,
                      decoration: ShapeDecoration(
                        color: AppColor.of.gray2,
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onVerticalDragDown: (_) {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Column(
                    children: [
                      /// TOGGLE SWITCH <-> RESET BUTTON
                      headerSelectionView,
                      selectedTechSetListView,

                      /// `Expanded`로 `PageView`의 높이 보장
                      Expanded(
                        child: PageView(
                          controller: pageController(ref),
                          children: [
                            KeepAliveView(child: jobGroupView),
                            KeepAliveView(child: skillPageView),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
