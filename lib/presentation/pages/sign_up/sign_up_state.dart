import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_jobs_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_nickname_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';

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
}
