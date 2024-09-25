import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_event.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
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
      introTextView: GestureDetector(
        onTap: () {
          print(selectedGroupScrollController(ref).position.maxScrollExtent);
        },
        child: SignUpStepIntroMessage(
          title: tr(LocaleKeys.jobSelection_promptJobPositions),
          subTitle: tr(LocaleKeys.jobSelection_selectOneOrMore),
        ),
      ),
      selectedJogGroupSlider: SelectedJobGroupListViewDelegate(
        selectedJobGroups: selectedJobGroups(ref),
        onTapItem: (item) {
          onJogGroupChipTapped(ref, item: item);
        },
        scrollController: selectedGroupScrollController(ref),
      ),
      totalJobGroupListView: JobGroupSliverListView(
        selectedJobGroups: selectedJobGroups(ref),
        onItemTap: (item) {
          onJobGroupListTileTapped(ref, item: item);
        },
      ),
      bottomFixedBtn: const _SaveBtn(),
    );
  }

  @override
  bool get setBottomSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}

class _SaveBtn extends ConsumerWidget
    with JobGroupSettingState, JobGroupSettingEvent {
  const _SaveBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BounceTapper(
      enable: isBottomFixedBtnActivate(ref),
      child: FilledButton(
        onPressed: isBottomFixedBtnActivate(ref)
            ? () {
                onSaveBtnTapped(ref);
              }
            : null,
        child: Center(
          child: Text(
            context.tr(
              LocaleKeys.common_save,
            ),
          ),
        ),
      ),
    );
  }
}
