import 'dart:developer';

import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/sign_up/events/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
import 'package:techtalk/presentation/widgets/common/chip/closable_skill_filled_chip.dart';
import 'package:techtalk/presentation/widgets/common/input/techtalk_text_field.dart';
import 'package:techtalk/presentation/widgets/section/searched_skill_list_view.dart';
import 'package:techtalk/presentation/widgets/section/skill_selection_scaffold.dart';

class SkillSelectStep extends HookConsumerWidget with SignUpState, SignUpEvent {
  const SkillSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return SkillSelectionScaffold(
      introTextView: SignUpStepIntroMessage(
        title: tr(LocaleKeys.techSelection_promptTechInterviewTopics),
        subTitle: tr(LocaleKeys.techSelection_searchInEnglish),
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
      child: TechtalkTextField(
        inputDecoration: InputDecoration(
          hintText: tr(LocaleKeys.techSelection_searchTechnologies),
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
                  child: ClosableFilledChip(
                    logoPath: item.imagePath,
                    name: item.name,
                    onTap: () {
                      onSkillChipTapped(ref, index: index);
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

class _StepBtn extends ConsumerWidget with SignUpState, SignUpEvent {
  const _StepBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BounceTapper(
      enable: isSkillSelectionFilled(ref),
      child: FilledButton(
        onPressed: isSkillSelectionFilled(ref)
            ? () => onSignUpBtnTapped(
                  ref,
                )
            : null,
        child: Center(
          child: Text(
            context.tr(
              LocaleKeys.common_start,
            ),
          ),
        ),
      ),
    );
  }
}
