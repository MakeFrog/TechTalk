part of '../question_creation_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    super.key,
    required this.leadingView,
    required this.illustView,
  });

  final Widget leadingView;
  final Widget illustView;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        leadingView,
        const Spacer(
          flex: 104,
        ),
        illustView,
        const Spacer(
          flex: 166,
        ),
      ],
    );
  }
}
