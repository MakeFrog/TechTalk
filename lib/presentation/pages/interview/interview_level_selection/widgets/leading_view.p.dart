part of '../interview_level_selection_page.dart';

class _LeadingView extends StatelessWidget {
  const _LeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        tr(LocaleKeys.interview_interviewLevel_title),
        style: AppTextStyle.headline1,
      ),
    );
  }
}
