import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/sign_up/events/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/section/job_group_selection_scaffold.dart';
import 'package:techtalk/presentation/widgets/section/job_group_sliver_list_view.dart';
import 'package:techtalk/presentation/widgets/section/selected_job_group_list_view_delegate.dart';

class JobGroupSelectStep extends HookConsumerWidget
    with SignUpState, SignUpEvent {
  const JobGroupSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return JobGroupSelectionScaffold(
      introTextView: const SignUpStepIntroMessage(
        title: '관심있는 직군을\n알려주세요.',
        subTitle: '1개 이상 선택해 주세요.',
      ),
      selectedJogGroupSlider: SelectedJobGroupListViewDelegate(
        selectedJobGroups: selectedJobGroups(ref),
        onTapItem: (item) {
          onJobGroupItemTapped(ref, item: item);
        },
        scrollController: selectedJobGroupScrollController(ref),
      ),
      totalJobGroupListView: JobGroupSliverListView(
        selectedJobGroups: selectedJobGroups(ref),
        onItemTap: (item) {
          onJobGroupItemTapped(ref, item: item);
        },
      ),
      bottomFixedBtn: FilledButton(
        onPressed: isJobGroupSelectionFilled(ref)
            ? () => onJobGroupStepBtnTapped(ref)
            : null,
        child: const Center(
          child: Text('다음'),
        ),
      ),
    );
  }
}
