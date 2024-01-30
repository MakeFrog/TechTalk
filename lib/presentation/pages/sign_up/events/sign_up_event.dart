import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/providers/input/skill_text_field_controller_provider.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'job_group_step_event.p.dart';
part 'nickname_step_event.p.dart';
part 'skill_step_event.p.dart';

mixin class SignUpEvent {
  ///
  /// 뒤로 가기 버튼이 클릭 되었을 때
  ///
  void onTapBackButton(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).prev();
  }

  ///
  /// 저장하기 버튼이 클릭 되었을 때
  ///
  Future<void> onSignUpBtnTapped(WidgetRef ref) async {
    try {
      await EasyLoading.show();

      final userData = UserEntity(
        uid: ref.read(userAuthProvider)!.uid,
        nickname: ref.read(nicknameInputProvider),
        jobGroups: ref.read(selectedJobGroupsProvider),
        skills: ref.read(selectedSkillsProvider),
        lastLoginDate: DateTime.now(),
        recordedTopicIds: [],
      );

      await ref.read(userInfoProvider.notifier).createData(userData).then(
        (_) {
          const MainRoute().go(ref.context);
        },
      );
    } finally {
      await EasyLoading.dismiss();
    }
  }
}
