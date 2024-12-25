part of '../youtube_content_main_page.dart';

class _CategorySliderBar extends ConsumerWidget {
  const _CategorySliderBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (_, __) => Gap(4),
          itemBuilder: (context, index) {
            return Text('data');
          },
        ),
      ),
    );
  }
}
