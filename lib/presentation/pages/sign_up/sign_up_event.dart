import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

mixin class SignUpEvent {
  String? validateNickname(String nickname) {
    if (nickname.isEmpty) {
      return null;
    } else if (nickname.hasSpace) {
      return '닉네임에 공백이 포함되어 있습니다.';
    } else if (!nickname.hasProperCharacter) {
      return '닉네임은 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다.';
    } else if (nickname.hasContainFWord) {
      return '닉네임에 비속어가 포함되어 있습니다.';
    } else if (nickname.hasContainOperationWord) {
      return '허용되지 않는 단어가 포함되어 있습니다.';
    } else {
      return null;
    }
  }

  void onTapBackButton(WidgetRef ref) {
    if (ref.read(signUpStepControllerProvider).page!.round() == 0) {
      DialogService.show(
        dialog: AppDialog(
          title: '회원가입을 중단하시곘습니까?',
          subTitle: '나가',
          isDividedBtnFormat: true,
          btnText: '네',
          onBtnClicked: () async {
            await FirebaseAuth.instance.signOut();
            await ref.read(userDataProvider.notifier).deleteData();
            ref.context
              ..pop()
              ..pop();
          },
          leftBtnText: '아니오',
          onLeftBtnClicked: () => Navigator.pop(ref.context),
        ),
      );
    } else {
      ref.read(signUpStepControllerProvider.notifier).prev();
    }
  }

  Future<void> onTapNicknameStepNext(
    WidgetRef ref, {
    required String nickname,
    required ValueNotifier<String?> nicknameValidation,
  }) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      await EasyLoading.show();

      final userData = ref.read(userDataProvider).requireValue!.copyWith(
            nickname: nickname,
          );

      await ref.read(userDataProvider.notifier).updateData(userData);

      ref.read(signUpStepControllerProvider.notifier).next();
    } on AlreadyExistNicknameException catch (e) {
      nicknameValidation.value = '중복된 닉네임입니다.';
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onTapJobGroupStepNext(
    WidgetRef ref, {
    required List<JobEntity> jobGroups,
  }) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      await EasyLoading.show();
      final userData = ref.read(userDataProvider).requireValue!.copyWith(
        jobGroupIds: [...jobGroups.map((e) => e.id)],
      );

      await ref.read(userDataProvider.notifier).updateData(userData);

      ref.read(signUpStepControllerProvider.notifier).next();
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onTapSignUp(
    WidgetRef ref, {
    required List<TopicEntity> topics,
  }) async {
    try {
      await EasyLoading.show();

      final userData = ref.read(userDataProvider).requireValue!.copyWith(
        topicIds: [...topics.map((e) => e.id)],
      );

      await ref.read(userDataProvider.notifier).updateData(userData).then(
        (_) {
          const MainRoute().go(ref.context);
        },
      );
    } finally {
      await EasyLoading.dismiss();
    }
  }
}
