import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/providers/input/skill_text_field_controller_provider.dart';
import 'package:techtalk/presentation/providers/scroll/selected_job_group_scroll_controller.dart';
import 'package:techtalk/presentation/providers/scroll/selected_skill_scroll_controller.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';

mixin class SignUpState {
  ///
  /// 페이지 컨트롤러
  ///
  PageController signUpStepController(WidgetRef ref) =>
      ref.watch(signUpStepControllerProvider);

  ///
  /// 유저 auth 이름
  ///
  String? userDisplayName(WidgetRef ref) =>
      ref.watch(userAuthProvider)?.displayName;

  ///
  /// 선택된 직군
  ///
  List<JobGroup> selectedJobGroups(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider);

  ///
  /// 선택된 직군이 존재 여부
  ///
  bool isJobGroupSelectionFilled(WidgetRef ref) =>
      ref.watch(selectedJobGroupsProvider).isNotEmpty;

  ///
  /// 검색된 스킬 리스트
  ///
  List<SkillEntity> searchedSkills(WidgetRef ref) =>
      ref.watch(searchedSkillsProvider);

  ///
  /// 선택된 스킬 리스트
  ///
  List<SkillEntity> selectedSkills(WidgetRef ref) =>
      ref.watch(selectedSkillsProvider);

  ///
  /// 스킬 검색 Text Field 컨트롤러
  ///
  TextEditingController skillTextFieldController(WidgetRef ref) =>
      ref.watch(skillTextFieldControllerProvider);

  ///
  /// 검색어
  ///
  String searchedTerm(WidgetRef ref) =>
      ref.watch(skillTextFieldControllerProvider).text;

  ///
  /// 선택된 스킬 존재 여부
  ///
  bool isSkillSelectionFilled(WidgetRef ref) =>
      ref.watch(selectedSkillsProvider).isNotEmpty;

  ///
  /// 선택된 직군 슬라이더 스크롤 컨트롤러
  ///
  ScrollController selectedJobGroupScrollController(WidgetRef ref) =>
      ref.watch(selectedJobGroupScrollControllerProvider);

  ///
  /// 선택된 직군 슬라이더 스크롤 컨트롤러
  ///
  ScrollController selectedSkillScrollController(WidgetRef ref) =>
      ref.watch(selectedSkillScrollControllerProvider);
}
