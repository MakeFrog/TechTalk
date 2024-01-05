import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_event.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_state.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/section/job_group_selection_scaffold.dart';
import 'package:techtalk/presentation/widgets/section/job_group_sliver_list_view.dart';
import 'package:techtalk/presentation/widgets/section/selected_job_group_list_view_delegate.dart';

class JobGroupSettingPage extends BasePage
    with JobGroupSettingState, JobGroupSettingEvent {
  const JobGroupSettingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return JobGroupSelectionScaffold(
      introTextView: const SignUpStepIntroMessage(
        title: '관심있는 직군을\n알려주세요.',
        subTitle: '1개 이상 선택해 주세요.',
      ),
      selectedJogGroupSlider: SelectedJobGroupListViewDelegate(
        selectedJobGroups: selectedJobGroups(ref),
        onTapItem: (item) {
          onJogGroupChipTapped(ref, item: item);
        },
      ),
      totalJobGroupListView: JobGroupSliverListView(
        selectedJobGroups: selectedJobGroups(ref),
        onItemTap: (item) {
          onJobGroupListTileTapped(ref, item: item);
          print('[유저]현재 상태 : ${ref.read(userDataProvider).value!.jobGroups}');
          print('[구파]현재 상태 : ${ref.read(selectedJobGroupsProvider)}');
        },
      ),
      bottomFixedBtn: FilledButton(
        onPressed: isBottomFixedBtnActivate(ref)
            ? () {
                saveEditedJobGroups(ref);
              }
            : null,
        child: Center(
          child: Text('저장하기'),
        ),
      ),
    );
  }

  @override
  bool get wrapWithSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}
