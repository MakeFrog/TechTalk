import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/providers/sign_up/sign_up_form_provider.dart';
import 'package:techtalk/presentation/providers/skill/searched_skills_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SkillSelectStep extends HookWidget with SignUpEvent {
  const SkillSelectStep({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SignUpStepIntroMessage(
            title: '준비하고 있는 기술면접\n주제를 알려주세요!',
            subTitle: '나중에 선택할 수 있어요.',
          ),
        ),
        _buildSelectedSkills(),
        const Gap(16),
        _buildSearchedSkills(),
        _buildSignUpButton(),
      ],
    );
  }

  Widget _buildSelectedSkills() {
    return HookConsumer(
      builder: (context, ref, child) {
        final selectedSkills = ref.watch(
          signUpFormProvider.select((v) => v.skills),
        );

        return SelectResultChipListView(
          itemList: selectedSkills.map((e) => e.name).toList(),
          onTapItem: (index) => onTapSelectedSkill(
            ref,
            skill: selectedSkills[index],
          ),
        );
      },
    );
  }

  Widget _buildSearchedSkills() {
    return HookBuilder(
      builder: (context) {
        final controller = useTextEditingController();

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                ClearableTextField(
                  controller: controller,
                  inputDecoration: const InputDecoration(
                    hintText: '관심 기술을 검색해 주세요',
                  ),
                ),
                Expanded(
                  child: HookConsumer(
                    builder: (context, ref, child) {
                      final keyword = useListenableSelector(
                        controller,
                        () => controller.text,
                      );
                      final searchedSkillsAsync = ref.watch(
                        searchedTechSkillListProvider(
                          keyword: keyword,
                        ),
                      );

                      return searchedSkillsAsync.when(
                        loading: SizedBox.new,
                        error: (error, stackTrace) => Center(
                          child: Text('$error'),
                        ),
                        data: (skills) {
                          return ListView.builder(
                            itemCount: skills.length,
                            itemExtent: 52,
                            itemBuilder: (context, index) {
                              final skill = skills[index];

                              final dimmedText =
                                  skill.name.replaceAll(keyword, '');

                              return ListTile(
                                minVerticalPadding: 0,
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: keyword,
                                        ),
                                        TextSpan(
                                          text: dimmedText,
                                          style: TextStyle(
                                            color: AppColor.of.gray4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: AppTextStyle.body2,
                                  ),
                                ),
                                onTap: () => onTapSkill(
                                  ref,
                                  skill: skill,
                                  controller: controller,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () => onTapSignUp(ref),
            child: const Center(
              child: Text('회원가입'),
            ),
          ),
        );
      },
    );
  }
}
