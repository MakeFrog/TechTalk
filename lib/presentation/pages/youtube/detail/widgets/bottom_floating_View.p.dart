part of '../youtube_detail_page.dart';

class _BottomFloatingView extends ConsumerWidget {
  const _BottomFloatingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 72 + AppSize.responsiveBottomInset,
      padding: EdgeInsets.only(bottom: AppSize.responsiveBottomInset),
      color: Colors.red,
      width: double.infinity,
    );
  }
}
