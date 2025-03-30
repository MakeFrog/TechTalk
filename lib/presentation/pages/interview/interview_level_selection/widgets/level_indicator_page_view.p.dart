part of '../interview_level_selection_page.dart';

class _LevelIndicatorPageView extends ConsumerWidget
    with InterviewLevelSelectionState, InterviewLevelSelectionEvent {
  const _LevelIndicatorPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpandablePageView.builder(
        itemCount: InterviewLevel.values.length,
        controller: pageController(ref),
        itemBuilder: (context, index) {
          final item = InterviewLevel.values[index];
          return Column(
            children: [
              /// LEADING INDICIATOR
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColor.of.blue1,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  tr(item.titleKey),
                  style: AppTextStyle.title1.copyWith(
                    color: AppColor.of.blue3,
                  ),
                ),
              ),

              const Gap(12),

              /// DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  tr(item.descriptionKey),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body2.copyWith(
                    color: AppColor.of.gray4,
                  ),
                ),
              ),
              const Gap(12),
              SvgPicture.asset(item.illustPath),
            ],
          );
        });
  }
}
