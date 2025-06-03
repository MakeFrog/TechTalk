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
            '기술 면접과 관련된\n스킬 또는 직군을 알려주세요',
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            '최대 4개까지 선택할 수 있어요',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
        ],
      ),
    );
  }
}
