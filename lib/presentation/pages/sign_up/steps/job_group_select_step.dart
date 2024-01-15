import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/tech_set/data/models/job_model.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/section/job_group_selection_scaffold.dart';
import 'package:techtalk/presentation/widgets/section/job_group_sliver_list_view.dart';
import 'package:techtalk/presentation/widgets/section/selected_job_group_list_view_delegate.dart';

class JobGroupSelectStep extends HookConsumerWidget
    with SignUpState, SignUpEvent {
  const JobGroupSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return JobGroupSelectionScaffold(
      introTextView: const SignUpStepIntroMessage(
        title: '관심있는 직군을\n알려주세요.',
        subTitle: '1개 이상 선택해 주세요.',
      ),
      selectedJogGroupSlider: SelectedJobGroupListViewDelegate(
        selectedJobGroups: selectedJobGroups(ref),
        onTapItem: (item) {
          // onJogGroupChipTapped(ref, item: item);
        },
      ),
      totalJobGroupListView: JobGroupSliverListView(
        selectedJobGroups: selectedJobGroups(ref),
        onItemTap: (item) {
          onJobGroupListTileTapped(ref, item: item);
        },
      ),
      bottomFixedBtn: FilledButton(
        onPressed: isJobGroupSelectionFilled(ref)
            ? () {
                // onJobGroupListTileTapped(ref, item: null);
              }
            : null,
        child: const Center(
          child: Text('다음'),
        ),
      ),
    );

    // useAutomaticKeepAlive();
    // final selectedJobGroups = useState<List<JobEntity>>([]);
    //
    // return Column(
    //   children: [
    //     Expanded(
    //       child: CustomScrollView(
    //         slivers: [
    //           const SliverToBoxAdapter(
    //             child: Padding(
    //               padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
    //               child: SignUpStepIntroMessage(
    //                 title: '관심있는 직군을\n알려주세요.',
    //                 subTitle: '1개 이상 선택해 주세요.',
    //               ),
    //             ),
    //           ),
    //           SliverPersistentHeader(
    //             floating: true,
    //             pinned: true,
    //             delegate: _SelectedJobGroupListViewDelegate(
    //               jobGroups: selectedJobGroups.value,
    //               onTapItem: (index) => selectedJobGroups.value =
    //                   selectedJobGroups.value..removeAt(index),
    //             ),
    //           ),
    //           HookBuilder(
    //             builder: (context) {
    //               final jobGroups = getJobsUseCase().getOrThrow();
    //
    //               return SliverList.builder(
    //                 itemCount: jobGroups.length,
    //                 itemBuilder: (context, index) {
    //                   final group = jobGroups[index];
    //                   final isSelected =
    //                       selectedJobGroups.value.contains(group);
    //
    //                   return ListTile(
    //                     selected: isSelected,
    //                     selectedColor: AppColor.of.black,
    //                     selectedTileColor: AppColor.of.background1,
    //                     minVerticalPadding: 0,
    //                     contentPadding:
    //                         const EdgeInsets.symmetric(horizontal: 16),
    //                     title: Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: Text(
    //                         group.name,
    //                         style: AppTextStyle.body2,
    //                       ),
    //                     ),
    //                     trailing: isSelected
    //                         ? FaIcon(
    //                             FontAwesomeIcons.solidCircleCheck,
    //                             color: AppColor.of.brand2,
    //                             size: 20,
    //                           )
    //                         : null,
    //                     onTap: () {
    //                       if (selectedJobGroups.value.contains(group)) {
    //                         selectedJobGroups.value =
    //                             selectedJobGroups.value.toList()..remove(group);
    //                       } else {
    //                         selectedJobGroups.value =
    //                             selectedJobGroups.value.toList()..add(group);
    //                       }
    //                     },
    //                   );
    //                 },
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(16),
    //       child: FilledButton(
    //         onPressed: selectedJobGroups.value.isNotEmpty
    //             ? () => onTapJobGroupStepNext(
    //                   ref,
    //                   jobGroups: selectedJobGroups.value,
    //                 )
    //             : null,
    //         child: const Center(
    //           child: Text('다음'),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}

class _SelectedJobGroupListViewDelegate extends SliverPersistentHeaderDelegate {
  const _SelectedJobGroupListViewDelegate({
    required this.jobGroups,
    required this.onTapItem,
  });

  final List<Job> jobGroups;
  final void Function(int index) onTapItem;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      alignment: Alignment.center,
      height: 68,
      color: Colors.white,
      child: SelectResultChipListView(
        itemList: jobGroups.map((e) => e.name).toList(),
        onTapItem: onTapItem,
      ),
    );
  }

  @override
  double get maxExtent => 68;

  @override
  double get minExtent => 68;

  @override
  bool shouldRebuild(covariant _SelectedJobGroupListViewDelegate oldDelegate) {
    return oldDelegate.jobGroups != jobGroups;
  }
}
