part of '../interview_level_selection_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold(
      {super.key,
      required this.leadingView,
      required this.levelIndicatorPageView,
      required this.levelSelectionBts});

  final Widget leadingView;
  final Widget levelIndicatorPageView;
  final Widget levelSelectionBts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          leadingView,

          const Spacer(
            flex: 60,
          ),
          levelIndicatorPageView,

          const Gap(16),

          /// LEVEL SELECTION BUTTON
          levelSelectionBts,
          const Spacer(
            flex: 122,
          ),
        ],
      ),
    );
  }
}
