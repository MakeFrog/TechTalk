import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/sign_up/events/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/input/clearable_text_field.dart';
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
      selectedSkillSlider: const _SelectedListViewSlider(),
      searchBar: const _SearchBar(),
      searchedSkillListView: SearchedSkillListView(
        items: searchedSkills(ref),
        searchedTerm: searchedTerm(ref),
        onItemTapped: (item) {
          onSearchedSkillTapped(ref, targetSkill: item);
        },
      ),
      bottomFixedBtn: const _StepBtn(),
    );
  }
}

class _SearchBar extends ConsumerWidget with SignUpState, SignUpEvent {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ClearableTextField(
        inputDecoration: const InputDecoration(
          hintText: '관심 기술을 검색해 주세요',
        ),
        controller: skillTextFieldController(ref),
        validator: (input) => skillInputValidation(ref, searchedTerm: input),
        onClear: () {
          onSkillFieldClear(ref);
        },
        onChanged: (searchedTerm) {
          onSkillFiledChanged(ref, searchedTerm: searchedTerm);
        },
      ),
    );
  }
}

class _SelectedListViewSlider extends ConsumerWidget
    with SignUpState, SignUpEvent {
  const _SelectedListViewSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      height: selectedSkills(ref).isNotEmpty ? 36 : 0,
      margin: EdgeInsets.only(
        top: selectedSkills(ref).isNotEmpty ? 16 : 0,
      ),
      duration: const Duration(milliseconds: 200),
      child: SelectResultChipListView(
        itemList: selectedSkills(ref).map((e) => e.name).toList(),
        onTapItem: (index) {
          onSkillChipTapped(ref, index: index);
        },
      ),
    );
  }
}

class _StepBtn extends ConsumerWidget with SignUpState, SignUpEvent {
  const _StepBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: isSkillSelectionFilled(ref)
          ? () => onSignUpBtnTapped(
                ref,
              )
          : null,
      child: const Center(
        child: Text('시작하기'),
      ),
    );
  }
}
