import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/data_source/remote/models/job_model.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_jobs_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_topics_provider.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/providers/input/skill_text_field_controller_provider.dart';
import 'package:techtalk/presentation/providers/scroll/selected_job_group_scroll_controller.dart';
import 'package:techtalk/presentation/providers/scroll/selected_skill_scroll_controller.dart';

mixin class SignUpState {
  PageController signUpStepController(WidgetRef ref) =>
      ref.watch(signUpStepControllerProvider);

  String? signUpNickname(WidgetRef ref) => ref.watch(nicknameInputProvider);

  String? signUpNicknameValidation(WidgetRef ref) =>
      ref.watch(nicknameInputProvider);

  List<Job> signUpJobs(WidgetRef ref) => ref.watch(signUpJobsProvider);

  List<TopicEntity> signUpTopics(WidgetRef ref) =>
      ref.watch(signUpTopicsProvider);

  ///
  /// 닉네임 유효성 여부
  ///
  bool isNicknameConditionFilled(WidgetRef ref) {
    final nicknameValidation =
        ref.read(nicknameInputProvider.notifier).nickNameValidation();

    return nicknameValidation == null ? true : false;
  }

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
