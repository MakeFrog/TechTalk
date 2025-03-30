part of '../proficiency_interview_topic_selection_page.dart';

class _LeadingView extends StatelessWidget {
  const _LeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            tr(LocaleKeys.interview_proficiency_title),
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            tr(LocaleKeys.interview_proficiency_maxSelection),
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
        ],
      ),
    );
  }
}
