import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';

mixin class SignUpState {
  ///
  /// 선택된 직군
  ///
  List<JobGroup> selectedJobGroups(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider);

  ///
  /// 선택된 직군이 조재 여부
  ///
  bool isJobGroupSelectionFilled(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider).isNotEmpty;
}
