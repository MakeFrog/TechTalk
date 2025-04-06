part of '../tech_set_selection_bottom_sheet.dart';

class _HeaderSelectionView extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const _HeaderSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Consumer(
        builder: (context, ref, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HookBuilder(
                builder: (context) {
                  final selectedTechSetType =
                      useListenableSelector(pageController(ref), () {
                    final index = pageController(ref).hasClients
                        ? pageController(ref).page?.round() ?? 0
                        : 0;
                    return TechSetType.values[index];
                  });
                  return Wrap(
                    children: [
                      ...TechSetType.values.map(
                        (type) {
                          final isSelected = selectedTechSetType == type;
                          return Padding(
                            padding: (type.index == 0
                                ? const EdgeInsets.only(right: 8)
                                : EdgeInsets.zero),
                            child: BounceTapper(
                              delayedDurationBeforeGrow: Duration.zero,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                onTechSelectionTapped(ref, type: type);
                              },
                              child: Text(
                                type.label,
                                style: AppTextStyle.headline2.copyWith(
                                  color: isSelected
                                      ? AppColor.of.gray6
                                      : AppColor.of.gray3,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
              BounceTapper(
                enable: selectedTechSets(ref).isNotEmpty,
                onTap: () {
                  onConfirmBtnTapped(ref);
                },
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                  ),
                  onPressed: selectedTechSets(ref).isNotEmpty ? () {} : null,
                  child: Text(
                    '완료',
                    style: AppTextStyle.title3,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
