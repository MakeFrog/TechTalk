import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_jobs_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_nickname_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_topics_provider.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

mixin class SignUpEvent {
  void onTapBackButton(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).prev();
  }

  void onChangeNicknameField(
    WidgetRef ref, {
    required String value,
  }) {
    ref.read(signUpNicknameProvider.notifier).updateState(value);
  }

  void onClearNicknameField(WidgetRef ref) {
    ref.invalidate(signUpNicknameProvider);
  }

  Future<void> onTapNicknameStepNext(WidgetRef ref) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final isDuplicated =
        await ref.read(signUpNicknameProvider.notifier).checkDuplication();

    if (isDuplicated) {
      ref
          .read(signUpNicknameValidationProvider.notifier)
          .updateState('사용중인 닉네임입니다.');

      return;
    }

    ref.read(signUpStepControllerProvider.notifier).next();
  }

  void onTapSelectedJob(WidgetRef ref, int index) {
    ref.read(signUpJobsProvider.notifier).removeAt(index);
  }

  void onTapJob(
    WidgetRef ref,
    JobEntity job,
  ) {
    ref.read(signUpJobsProvider.notifier).toggle(job);
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
        nickname: ref.read(signUpNicknameProvider),
        jobGroupIds: ref.read(signUpJobsProvider).map((e) => e.id).toList(),
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
