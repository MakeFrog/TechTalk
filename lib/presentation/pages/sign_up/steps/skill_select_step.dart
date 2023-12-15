import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/searched_tech_skill_list_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SkillSelectStep extends HookWidget {
  const SkillSelectStep({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: SignUpStepIntroMessage(
            title: '준비하고 있는 기술면접\n주제를 알려주세요!',
            subTitle: '나중에 선택할 수 있어요.',
          ),
        ),
        _SelectedSkillListView(),
        Gap(16),
        _SkillListView(),
        _NextButton(),
      ],
    );
  }
}

class _SelectedSkillListView extends ConsumerWidget with SignUpEvent {
  const _SelectedSkillListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSkills = ref.watch(
      signUpFormProvider.select((v) => v.techSkillList),
    );

    return SelectResultChipListView(
      itemList: selectedSkills.map((e) => e.name).toList(),
      onTapItem: (index) => onTapSelectedSkill(
        ref,
        skill: selectedSkills[index],
      ),
    );
  }
}

class _SkillListView extends HookConsumerWidget with SignUpEvent {
  const _SkillListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onChanged: (value) => onChangeSkillSearchField(
                ref,
                keyword: value,
              ),
              onClear: () => onClearSkillSearchField(
                ref,
                controller: controller,
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final keyword = ref.watch(techSkillSearchKeywordProvider);
                  final searchedSkillsAsync =
                      ref.watch(searchedTechSkillListProvider);

                  return searchedSkillsAsync.when(
                    loading: SizedBox.new,
                    error: (error, stackTrace) => Center(
                      child: Text('$error'),
                    ),
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.skills.length,
                        itemExtent: 52,
                        itemBuilder: (context, index) {
                          final skill = data.skills[index];

                          final dimmedText = skill.name.replaceAll(keyword, '');

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
                            onTap: () => onTapTechSkillListTile(
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
  }
}

class _NextButton extends ConsumerWidget with SignUpEvent {
  const _NextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton(
        onPressed: () => onTapTechSkillStepNext(ref),
        child: const Center(
          child: Text('다음'),
        ),
      ),
    );
  }
}
