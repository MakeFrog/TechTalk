part of '../interview_level_selection_page.dart';

class _LeadingView extends StatelessWidget {
  const _LeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '면접 질문 난이도를\n선택해주세',
        style: AppTextStyle.headline1,
      ),
    );
  }
}
