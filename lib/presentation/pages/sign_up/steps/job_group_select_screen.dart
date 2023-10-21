import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/job_group_list_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class JobGroupSelectScreen extends HookWidget {
  const JobGroupSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: const SignUpStepIntroMessage(
            title: '관심있는 직군을\n알려주세요.',
            subTitle: '1개 이상 선택해 주세요.',
          ),
        ),
        const _SelectedJobGroupListView(),
        HeightBox(16.h),
        _JobGroupListView(),
        _NextButton(),
      ],
    );
  }
}

class _SelectedJobGroupListView extends ConsumerWidget with SignUpEvent {
  const _SelectedJobGroupListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedJobGroups = ref.watch(
      signUpFormProvider.select((v) => v.jobGroupList),
    );

    return SelectResultChipListView(
      itemList: selectedJobGroups.map((e) => e.name).toList(),
      onTapItem: (index) => onTapSelectedJobGroup(
        ref,
        group: selectedJobGroups[index],
      ),
    );
  }
}

class _JobGroupListView extends ConsumerWidget with SignUpEvent {
  const _JobGroupListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobGroupListAsync = ref.watch(jobGroupListProvider);
    final selectedGroupList = ref.watch(
      signUpFormProvider.select((v) => v.jobGroupList),
    );

    return Expanded(
      child: jobGroupListAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('$error'),
        ),
        data: (data) {
          final groups = data.groups;

          return ListView.builder(
            itemExtent: 52.h,
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final isSelected = selectedGroupList.contains(group);

              return ListTile(
                selected: isSelected,
                selectedColor: AppColor.of.black,
                selectedTileColor: AppColor.of.background1,
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    group.name,
                    style: AppTextStyle.body2,
                  ),
                ),
                trailing: isSelected
                    ? FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: AppColor.of.brand2,
                        size: 20.r,
                      )
                    : null,
                onTap: () => onTapJobGroupListTile(
                  ref,
                  group: group,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NextButton extends ConsumerWidget with SignUpEvent {
  const _NextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelectedAtLeastOne = ref.watch(
      signUpFormProvider.select((value) => value.isSelectedAtLeastOneJobGroup),
    );

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: FilledButton(
        onPressed:
            isSelectedAtLeastOne ? () => onTapJobGroupStepNext(ref) : null,
        child: const Center(
          child: Text('다음'),
        ),
      ),
    );
  }
}
