part of '../blog_main_page.dart';

class _Scaffold extends StatelessWidget {
  final Widget categorySliderBar;
  final Widget contentListView;

  const _Scaffold({
    required this.categorySliderBar,
    required this.contentListView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        categorySliderBar,
        const Gap(6),
        Expanded(child: contentListView),
      ],
    );
  }
}
