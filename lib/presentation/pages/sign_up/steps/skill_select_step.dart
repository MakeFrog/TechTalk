import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/section/searched_skill_list_view.dart';
import 'package:techtalk/presentation/widgets/section/skill_selection_scaffold.dart';

class SkillSelectStep extends HookConsumerWidget with SignUpState, SignUpEvent {
  const SkillSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // onSelectableChipTapped(ref, index: index);
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
            onSkillFieldCloseBtnTapped(ref);
          },
          onChanged: (searchedTerm) {
            onSkillFiledChanged(ref, searchedTerm: searchedTerm);
          },
        ),
      ),
      searchedSkillListView: SearchedSkillListView(
        items: skills(ref),
        searchedTerm: searchedTerm(ref),
        onItemTapped: (item) {
          // onSearchedSkillTapped(ref, targetSkill: item);
        },
      ),
      bottomFixedBtn: FilledButton(
        onPressed: () => onTapSignUp(
          ref,
        ),
        child: const Center(
          child: Text('회원가입'),
        ),
      ),
    );
  }
}
