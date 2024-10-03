import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/skill_setting_state.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/skill_setting_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/input/clearable_text_field.dart';
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
      child: ClearableTextField(
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
    return BounceTapper(
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
    );
  }
}

class _SelectedListViewSlider extends ConsumerWidget
    with SkillSettingState, SkillSettingEvent {
  const _SelectedListViewSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      height: selectedSkills(ref).isNotEmpty ? 32 : 0,
      margin: EdgeInsets.only(
        top: selectedSkills(ref).isNotEmpty ? 16 : 0,
      ),
      duration: const Duration(milliseconds: 200),
      child: SelectResultChipListView(
        itemList: selectedSkills(ref).map((e) => e.name).toList(),
        onTapItem: (index) {
          onSelectableChipTapped(ref, index: index);
        },
        scrollController: selectedSkillScrollController(ref),
      ),
    );
  }
}
