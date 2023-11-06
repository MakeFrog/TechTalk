import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/searched_tech_skill_list_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TechSkillSelectScreen extends HookWidget {
  const TechSkillSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: const SignUpStepIntroMessage(
            title: '준비하고 있는 기술면접\n주제를 알려주세요!',
            subTitle: '1개 이상 선택해 주세요.',
          ),
        ),
        const _SelectedTechSkillListView(),
        HeightBox(16.h),
        _TechSkillListView(),
        _NextButton(),
      ],
    );
  }
}

class _SelectedTechSkillListView extends ConsumerWidget with SignUpEvent {
  const _SelectedTechSkillListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTechSkillList = ref.watch(
      signUpFormProvider.select((v) => v.techSkillList),
    );

    return SelectResultChipListView(
      itemList: selectedTechSkillList.map((e) => e.name).toList(),
      onTapItem: (index) => onTapSelectedTechSkill(
        ref,
        skill: selectedTechSkillList[index],
      ),
    );
  }
}

class _TechSkillListView extends HookConsumerWidget with SignUpEvent {
  const _TechSkillListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ClearableTextField(
              controller: controller,
              inputDecoration: const InputDecoration(
                hintText: '관심 기술을 검색해 주세요',
              ),
              onChanged: (value) => onChangeTechSkillSearchField(
                ref,
                keyword: value,
              ),
              onClear: () => onClearTechSkillSearchField(
                ref,
                controller: controller,
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final keyword = ref.watch(techSkillSearchKeywordProvider);
                  final searchedTechSkillListAsync =
                      ref.watch(searchedTechSkillListProvider);

                  return searchedTechSkillListAsync.when(
                    loading: SizedBox.new,
                    error: (error, stackTrace) => Center(
                      child: Text('$error'),
                    ),
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemExtent: 52.h,
                        itemBuilder: (context, index) {
                          final skill = data[index];

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
    final isSelectedAtLeastOne = ref.watch(
      signUpFormProvider.select((value) => value.isSelectedAtLeastOneTechSkill),
    );

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: FilledButton(
        onPressed:
            isSelectedAtLeastOne ? () => onTapTechSkillStepNext(ref) : null,
        child: const Center(
          child: Text('다음'),
        ),
      ),
    );
  }
}
