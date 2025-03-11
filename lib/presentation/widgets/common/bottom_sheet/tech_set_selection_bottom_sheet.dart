import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/search_tech_set_state.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/search_tehc_set_event.dart';

class TechSetSelectionBottomSheet extends ConsumerWidget
    with SearchTechSetState, SearchTechSetEvent {
  const TechSetSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollableSheet(
      maxPosition: const SheetAnchor.proportional(722 / 812),
      minPosition: const SheetAnchor.proportional(655 / 812),
      initialPosition: const SheetAnchor.proportional(655 / 812),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              IgnorePointer(
                child: SheetDraggable(
                  child: Container(
                    height: 36,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      height: 6,
                      width: 36,
                      decoration: ShapeDecoration(
                        color: AppColor.of.gray2,
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Consumer(
                      builder: (context, ref, child) {
                        return Row(
                          children: [
                            ...TechSetType.values.map(
                              (type) {
                                final isSelected =
                                    selectedTechSetType(ref) == type;
                                return Padding(
                                  padding: type.index == 0
                                      ? const EdgeInsets.only(right: 8)
                                      : EdgeInsets.zero,
                                  child: BounceTapper(
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
                  ),
                  const Text('data'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
