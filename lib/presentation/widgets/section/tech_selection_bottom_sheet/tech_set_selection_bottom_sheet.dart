import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/widgets/common/button/reset_button.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/section/searched_skill_list_view.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/tech_selection_bottom_sheet_state.dart';

import 'tech_selection_bottom_sheet_event.dart';

part 'widgets/searched_skill_list_view.p.dart';

class TechSetSelectionBottomSheet extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const TechSetSelectionBottomSheet({super.key});

  static SheetAnchor minProportional =
      const SheetAnchor.proportional(0.8066); // 655 / 812
  static SheetAnchor maxProportional =
      const SheetAnchor.proportional(0.8891); // 722 / 812;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(chatMessageHistoryProvider, (prev, now) {});
    return ScrollableSheet(
      // physics: SnappingSheetPhysics(),
      maxPosition: maxProportional,
      minPosition: minProportional,
      initialPosition: minProportional,
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
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    /// TOGGLE SWITCH <-> REST BUTTON
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: [
                                  ...TechSetType.values.map(
                                    (type) {
                                      final isSelected =
                                          selectedTechSetType(ref) == type;
                                      return Padding(
                                        padding: (type.index == 0
                                            ? const EdgeInsets.only(right: 8)
                                            : EdgeInsets.zero),
                                        child: BounceTapper(
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            onTechSelectionTapped(ref,
                                                type: type);
                                          },
                                          child: Text(
                                            type.label,
                                            style:
                                                AppTextStyle.headline2.copyWith(
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
                              ),
                              ResetButton(
                                onTap: () {},
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const Gap(12),

                    /// SEARCH BAR
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TechtalkTextField(
                          showPrefixIcon: true,
                          inputDecoration: const InputDecoration(
                            hintText: '스킬 및 직군을 검색해 주세요',
                          ),
                          controller: textEditingController(ref),
                          validator: (input) =>
                              skillInputValidator(ref, input: input),
                          onClear: () {
                            onSearchBarClearBtnTapped(ref);
                          },
                          onChanged: (searchedTerm) {
                            onFieldChanged(ref, searchedTerm: searchedTerm);
                          },
                        ),
                      ),
                    ),

                    /// SEARCHED LIST
                    const _SearchedSkillListView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
