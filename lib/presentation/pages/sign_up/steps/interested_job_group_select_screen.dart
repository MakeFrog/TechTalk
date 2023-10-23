import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/interested_job_group_list_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_introduction.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class InterestJobGroupSelectScreen extends StatelessWidget {
  const InterestJobGroupSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: SignUpStepIntroduction(
            title: '관심있는 직군을\n알려주세요.',
            subTitle: '1개 이상 선택해 주세요.',
          ),
        ),
        _InterestedJobGroupListView(),
        HeightBox(16),
        _JobGroupListView(),
        Padding(
          padding: EdgeInsets.all(16),
          child: FilledButton(
            onPressed: null,
            child: Center(
              child: Text('다음'),
            ),
          ),
        ),
      ],
    );
  }
}

class _InterestedJobGroupListView extends StatelessWidget with SignUpPageEvent {
  const _InterestedJobGroupListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final interestedJobGroups = ref.watch(interestedJobGroupListProvider);

        return SelectResultChipListView(
          stateKey: InterestedJobGroupList.stateKey,
          itemList: interestedJobGroups.map((e) => e.name).toList(),
          onTapItem: (index) => removeInterestGroup(ref, index: index),
        );
      },
    );
  }
}

class _JobGroupListView extends ConsumerWidget with SignUpPageEvent {
  const _JobGroupListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListAsync = ref.watch(jobGroupListProvider);
    final selectedGroupList = ref.watch(interestedJobGroupListProvider);

    return Expanded(
      child: groupListAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('$error'),
        ),
        data: (data) {
          final groups = data.groups;

          return ListView.builder(
            itemExtent: 52,
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final isSelected = selectedGroupList.contains(group);

              return ListTile(
                selected: isSelected,
                selectedColor: AppColor.of.black,
                selectedTileColor: AppColor.of.background1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  group.name,
                  style: AppTextStyle.body2,
                ),
                trailing: isSelected
                    ? FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: AppColor.of.brand2,
                        size: 20,
                      )
                    : null,
                onTap: isSelected
                    ? () => removeInterestGroup(
                          ref,
                          index: index,
                        )
                    : () => addInterestGroup(
                          ref,
                          index: index,
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
