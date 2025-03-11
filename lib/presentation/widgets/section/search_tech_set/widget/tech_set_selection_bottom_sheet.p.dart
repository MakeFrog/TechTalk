part of '../search_tech_set_page.dart';

class _TechSetSelectionBottomSheet extends ConsumerWidget
    with SearchTechSetState {
  const _TechSetSelectionBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handle = Container(
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
    );

    final content = ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );

    final body = Column(
      children: [
        // SheetDraggable enables the child widget to act as a drag handle for the sheet.
        // Typically, you will want to use this widget when placing non-scrollable widget(s)
        // in a ScrollableSheet, since it only works with scrollable widgets, so you can't
        // drag the sheet by touching a non-scrollable area. Try removing SheetDraggable and
        // you will see that the drag handle doesn't work as it should.
        //
        // Note that SheetDraggable is not needed when using DraggableSheet
        // since it implicitly wraps the child widget with SheetDraggable.
        SheetDraggable(child: handle),
        Expanded(child: content),
      ],
    );

    const minPosition = SheetAnchor.proportional(50);
    // const minPosition = SheetAnchor.proportional(655 / 812);
    const physics = BouncingSheetPhysics(
      parent: SnappingSheetPhysics(),
    );

    return Container(
      child: ScrollableSheet(
        physics: physics,
        controller: sheetController(ref),
        minPosition: minPosition,
        // minPosition: minPosition,
        initialPosition: minPosition,
        child: Card(
          margin: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: body,
        ),
      ),
    );

    return Padding(
      // padding: EdgeInsets.zero,
      padding: EdgeInsets.only(
        top: AppSize.statusBarHeight >= AppSize.ratioHeight(40)
            ? AppSize.statusBarHeight
            : AppSize.ratioHeight(40),
      ),
      child: NotificationListener<SheetNotification>(
        onNotification: (notification) {
          debugPrint('${notification.metrics}');
          return false;
        },
        child: ScrollableSheet(
          physics: physics,
          controller: sheetController(ref),
          minPosition: minPosition,
          // minPosition: minPosition,
          initialPosition: minPosition,
          child: Card(
            margin: EdgeInsets.zero,
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}

class AimExampleSheet extends StatelessWidget {
  const AimExampleSheet({
    required this.isFullScreen,
    required this.keyboardDismissBehavior,
  });

  final bool isFullScreen;
  final SheetKeyboardDismissBehavior? keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    Widget body = const SingleChildScrollView(
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Enter some text...',
        ),
      ),
    );

    if (isFullScreen) {
      body = SizedBox.expand(child: body);
    }

    return SheetKeyboardDismissible(
      dismissBehavior: keyboardDismissBehavior,
      child: ScrollableSheet(
        child: SheetContentScaffold(
          appBar: AppBar(),
          body: body,
          bottomBar: StickyBottomBarVisibility(
            child: BottomAppBar(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
