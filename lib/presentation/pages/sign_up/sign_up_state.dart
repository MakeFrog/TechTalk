import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_jobs_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_nickname_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_topics_provider.dart';

mixin class SignUpState {
  PageController signUpStepController(WidgetRef ref) =>
      ref.watch(signUpStepControllerProvider);

  String? signUpNickname(WidgetRef ref) => ref.watch(signUpNicknameProvider);
  String? signUpNicknameValidation(WidgetRef ref) =>
      ref.watch(signUpNicknameValidationProvider);
  bool isPassNickname(WidgetRef ref) =>
      (signUpNickname(ref)?.isNotEmpty ?? false) &&
      signUpNicknameValidation(ref) == null;

  List<JobEntity> signUpJobs(WidgetRef ref) => ref.watch(signUpJobsProvider);
  List<TopicEntity> signUpTopics(WidgetRef ref) =>
      ref.watch(signUpTopicsProvider);

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

