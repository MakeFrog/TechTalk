import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

mixin class JobGroupSettingState {
  ///
  /// 유저 정보
  ///
  UserEntity user(WidgetRef ref) => ref.watch(userDataProvider).value!;

  ///
  /// 선택된 직군 리스트
  ///
  List<JobGroup> selectedJobGroups(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider);

  ///
  /// 저장하기 버튼 활성화 여부
  ///
  bool isBottomFixedBtnActivate(WidgetRef ref) {
    final selectedJobGroups = ref.read(selectedJobGroupsProvider);

    if (selectedJobGroups.isEmpty) {
      return false;
    }

    final userJobGroups = ref.read(userDataProvider).value!.jobGroups;

    return !selectedJobGroups.isElementEquals(userJobGroups);
  }
}
