import 'dart:developer';

import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/skill_setting_state.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/skill_setting_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/chip/closable_skill_filled_chip.dart';
import 'package:techtalk/presentation/widgets/common/input/techtalk_text_field.dart';
import 'package:techtalk/presentation/widgets/section/searched_skill_list_view.dart';
import 'package:techtalk/presentation/widgets/section/skill_selection_scaffold.dart';

class SkillSettingPage extends BasePage
    with SkillSettingState, SkillSettingEvent {
  const SkillSettingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return SkillSelectionScaffold(
      introTextView: SignUpStepIntroMessage(
        title: context.tr(LocaleKeys.techSelection_promptTechInterviewTopics),
        subTitle: context.tr(LocaleKeys.techSelection_searchInEnglish),
      ),
      selectedSkillSlider: const _SelectedListViewSlider(),
      searchBar: const _SearchBar(),
      searchedSkillListView: SearchedSkillListView(
        items: searchedSkills(ref),
        searchedTerm: searchedTerm(ref),
        onItemTapped: (item) {
          onSearchedSkillTapped(ref, targetSkill: item);
        },
      ),
      bottomFixedBtn: const _SaveBtn(),
    );
  }

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();

  @override
  bool get resizeToAvoidBottomInset => false;
}

class _SearchBar extends ConsumerWidget
    with SkillSettingState, SkillSettingEvent {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TechtalkTextField(
        controller: skillTextFieldController(ref),
        inputDecoration: InputDecoration(
          hintText: context.tr(
            LocaleKeys.techSelection_searchTechnologies,
          ),
        ),
        validator: (input) => skillInputValidation(ref, searchedTerm: input),
        onClear: () {
          onSkillFieldClear(ref);
        },
        onChanged: (searchedTerm) {
          onFieldChanged(ref, searchedTerm: searchedTerm);
        },
      ),
    );
  }
}

class _SaveBtn extends ConsumerWidget
    with SkillSettingState, SkillSettingEvent {
  const _SaveBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: BounceTapper(
        enable: isBottomFixedBtnActivate(ref),
        child: FilledButton(
          onPressed: isBottomFixedBtnActivate(ref)
              ? () {
                  onSaveBtnTapped(ref);
                }
              : null,
          child: Center(
            child: Text(
              context.tr(
                LocaleKeys.common_save,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedListViewSlider extends ConsumerWidget
    with SkillSettingState, SkillSettingEvent {
  const _SelectedListViewSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSizeAndFade.showHide(
      show: selectedSkills(ref).isNotEmpty,
      child: Container(
        height: 32,
        margin: const EdgeInsets.only(
          top: 16,
        ),
        child: SizedBox(
          height: 36,
          child: ListView.separated(
            controller: selectedSkillScrollController(ref),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: selectedSkills(ref).length,
            separatorBuilder: (context, index) => const Gap(8),
            itemBuilder: (context, index) {
              try {
                final item = selectedSkills(ref)[index];

                return Align(
                  alignment: Alignment.topCenter,
                  child: ClosableSkillFilledChip(
                    skill: item,
                    onTap: () {
                      onSelectableChipTapped(ref, index: index);
                    },
                  ),
                );
              } catch (e) {
                /// NOTE
                /// [AnimatedSizeAndFade]에 걸려 있는 duration fade 때문에,
                /// 타겟하고 있는 배열에 더 이상 원소가 없을 경우 Range에러가 발생하는데
                /// 기능에 영향을 끼치지 않고 예상 가능한 오류라 이렇게 핸들링함.
                if (e is RangeError) {
                  log('오류가 아님 : $e');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
