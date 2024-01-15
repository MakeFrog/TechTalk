import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_topics_provider.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'job_group_event.p.dart';
part 'nickname_input_event.p.dart';

mixin class SignUpEvent {
  void onTapBackButton(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).prev();
  }

  Future<void> onTapJobStepNext(WidgetRef ref) async {
    ref.read(signUpStepControllerProvider.notifier).next();
  }

  void onTapSelectedTopic(WidgetRef ref, int index) {
    ref.read(signUpTopicsProvider.notifier).removeAt(index);
  }

  void onTapTopic(
    WidgetRef ref, {
    required TopicEntity item,
    required TextEditingController controller,
  }) {
    controller.clear();
    ref.read(signUpTopicsProvider.notifier).add(item);
  }

  Future<void> onTapSignUp(WidgetRef ref) async {
    try {
      await EasyLoading.show();

      final userData = UserEntity(
        uid: ref.read(userAuthProvider)!.uid,
        nickname: ref.read(nicknameInputProvider),
        jobGroups: ref.read(selectedJobGroupsProvider),
        topicIds: ref.read(signUpTopicsProvider).map((e) => e.id).toList(),
        lastLoginDate: DateTime.now(),
      );

      await ref.read(userDataProvider.notifier).createData(userData).then(
        (_) {
          const MainRoute().go(ref.context);
        },
      );
    } finally {
      await EasyLoading.dismiss();
    }
  }
}
