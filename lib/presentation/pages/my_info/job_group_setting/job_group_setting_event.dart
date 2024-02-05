import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class JobGroupSettingEvent {
  ///
  /// 직군 ListTile이 클릭되었을 때
  ///
  void onJobGroupListTileTapped(WidgetRef ref, {required JobGroup item}) {
    final selectedJobGroups = ref.read(selectedJobGroupsProvider);
    if (selectedJobGroups.contains(item)) {
      ref.read(selectedJobGroupsProvider.notifier).remove(item);
    } else {
      ref.read(selectedJobGroupsProvider.notifier).add(item);
    }
  }

  ///
  /// 선택된 직군 Chip 위젯이 클릭 되었을 때
  ///
  void onJogGroupChipTapped(WidgetRef ref, {required JobGroup item}) {
    ref.read(selectedJobGroupsProvider.notifier).remove(item);
  }

  ///
  /// 변경된 직군 정보 저장
  ///
  void onSaveBtnTapped(WidgetRef ref) {
    EasyLoading.show();
    final selectedJogGroups = ref.watch(selectedJobGroupsProvider);
    final user = ref
        .read(userInfoProvider)
        .value!
        .copyWith(jobGroups: selectedJogGroups);

    ref.read(userInfoProvider.notifier).updateData(user).whenComplete(() {
      EasyLoading.dismiss();
      ref.context.pop();
      SnackBarService.showSnackBar('직군 정보가 변경되었습니다');
    });
  }
}
