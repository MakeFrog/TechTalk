part of '../interview_level_selection_page.dart';

class _LevelSelectionBtns extends ConsumerWidget
    with InterviewLevelSelectionState, InterviewLevelSelectionEvent {
  const _LevelSelectionBtns({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HookBuilder(
        builder: (context) {
          final selectedLevel = useListenableSelector(pageController(ref), () {
            final InterviewLevel levelType =
                InterviewLevel.values[pageController(ref).page?.floor() ?? 1];
            return levelType;
          });

          return Row(
            children: [
              ...List.generate(
                InterviewLevel.values.length,
                (index) {
                  final item = InterviewLevel.values[index];
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          right: index != InterviewLevel.values.length - 1
                              ? 8
                              : 0),
                      height: 72,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          foregroundColor: selectedLevel == item
                              ? AppColor.of.blue3
                              : AppColor.of.gray3,
                          textStyle: AppTextStyle.headline2.copyWith(),
                          backgroundColor: selectedLevel == item
                              ? AppColor.of.blue1
                              : AppColor.of.background1,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),
                        ),
                        onPressed: () {
                          onLevelBtnTapped(ref, index: index);
                        },
                        child: FittedBox(child: Text(tr(item.labelKey))),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
