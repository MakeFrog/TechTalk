part of '../youtube_content_main_page.dart';

class _Scaffold extends HookWidget {
  const _Scaffold({
    super.key,
    required this.categorySliderBar,
    required this.contentListView,
  });

  final Widget categorySliderBar;
  final Widget contentListView;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0.0,
            titleSpacing: 0,
            toolbarHeight: 42,
            title: categorySliderBar,
          ),
        ];
      },
      body: contentListView,
    );
  }
}
