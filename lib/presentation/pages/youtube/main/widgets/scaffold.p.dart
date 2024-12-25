part of '../youtube_content_main_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    super.key,
    required this.categorySliderBar,
    required this.contentListView,
  });

  final Widget categorySliderBar;
  final Widget contentListView;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: StickyDelegateContainer(
            minHeight: 0,
            maxHeight: 42,
            child: categorySliderBar,
          ),
        ),
        contentListView,
      ],
    );
  }
}
