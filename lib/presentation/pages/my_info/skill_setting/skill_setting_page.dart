import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
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
  SkillSettingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return SkillSelectionScaffold(
      introTextView: const SignUpStepIntroMessage(
        title: '준비하고 있는 기술면접\n주제를 알려주세요!',
        subTitle: '영어로 검색해주세요',
      ),
      selectedSkillSlider: AnimatedContainer(
        height: ref.watch(selectedSkillsProvider).isNotEmpty ? 32 : 0,
        margin: EdgeInsets.only(
          top: ref.watch(selectedSkillsProvider).isNotEmpty ? 16 : 0,
        ),
        duration: const Duration(milliseconds: 200),
        child: SelectResultChipListView(
          itemList:
              ref.watch(selectedSkillsProvider).map((e) => e.name).toList(),
          onTapItem: (index) {
            onSelectableChipTapped(ref, index: index);
          },
        ),
      ),
      searchBar: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ClearableTextField(
          inputDecoration: const InputDecoration(
            hintText: '관심 기술을 검색해 주세요',
          ),
          validator: (input) => skillInputValidation(ref, searchedTerm: input),
          onClear: () {
            onFieldCloseBtnTapped(ref);
          },
          onChanged: (searchedTerm) {
            onFieldChanged(ref, searchedTerm: searchedTerm);
          },
        ),
      ),
      searchedSkillListView: SearchedSkillListView(
        items: skills(ref),
        searchedTerm: searchedTerm(ref),
        onItemTapped: (item) {
          onSearchedSkillTapped(ref, targetSkill: item);
        },
      ),
      bottomFixedBtn: FilledButton(
        onPressed: isBottomFixedBtnActivate(ref)
            ? () {
                onSaveBtnTapped(ref);
              }
            : null,
        child: const Center(
          child: Text('저장하기'),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}
