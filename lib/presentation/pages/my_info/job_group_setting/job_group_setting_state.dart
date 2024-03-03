import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/providers/scroll/selected_job_group_scroll_controller.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class JobGroupSettingState {
  ///
  /// 유저 정보
  ///
  UserEntity user(WidgetRef ref) => ref.watch(userInfoProvider).value!;

  ///
  /// 선택된 직군 리스트
  ///
  List<JobGroup> selectedJobGroups(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider);

  ///
  /// 저장하기 버튼 활성화 여부
  ///
  bool isBottomFixedBtnActivate(WidgetRef ref) {
    final selectedJobGroups = ref.watch(selectedJobGroupsProvider);

    if (selectedJobGroups.isEmpty) {
      return false;
    }

    final userJobGroups = ref.read(userInfoProvider).value!.jobGroups;

    return !selectedJobGroups.isElementEquals(userJobGroups);
  }

  ///
  /// 선택된 직군 슬라이더 스크롤 컨트롤러
  ///
  ScrollController selectedGroupScrollController(WidgetRef ref) =>
      ref.watch(selectedJobGroupScrollControllerProvider);
}
