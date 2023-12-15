import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/features/interview/entities/interview_topic.enum.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/presentation/providers/sign_up/sign_up_step_controller.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

abstract class _SignUpEvent {
  /// 앱바의 [BackButton]을 눌렀을 때 실행할 콜백
  ///
  /// 이전 회원가입 단계로 넘어간다. 이전 단계로 넘어갈 시 현재 단계에 작성한 데이터는 삭제한다.
  void onTapBackButton(WidgetRef ref);

  /// 닉네임 입력 스크린의 다음단계 버튼을 눌렀을 때 실행할 콜백
  Future<void> onTapNicknameStepNext(
    WidgetRef ref, {
    required String nickname,
    required ValueNotifier<String?> nicknameValidation,
  });

  Future<void> onTapJobGroupStepNext(
    WidgetRef ref, {
    required List<JobGroupEntity> jobGroups,
  });

  Future<void> onTapSignUp(
    WidgetRef ref, {
    required List<InterviewTopic> topics,
  });
}

mixin class SignUpEvent implements _SignUpEvent {
  @override
  void onTapBackButton(WidgetRef ref) {
    if (ref.read(signUpStepControllerProvider).page!.round() == 0) {
      DialogService.show(
        dialog: AppDialog(
          title: '회원가입을 중단하시곘습니까?',
          subTitle: '나가',
          isDividedBtnFormat: true,
          btnText: '네',
          onBtnClicked: () async {
            await ref.read(userDataProvider.notifier).deleteUserData();
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

  @override
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

      await ref.read(userDataProvider.notifier).updateUserData(userData);

      ref.read(signUpStepControllerProvider.notifier).next();
    } on AlreadyExistNicknameException catch (e) {
      nicknameValidation.value = '중복된 닉네임입니다.';
    } finally {
      await EasyLoading.dismiss();
    }
  }

  @override
  Future<void> onTapJobGroupStepNext(
    WidgetRef ref, {
    required List<JobGroupEntity> jobGroups,
  }) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      await EasyLoading.show();
      final userData = ref.read(userDataProvider).requireValue!.copyWith(
        jobGroupIds: [...jobGroups.map((e) => e.id)],
      );

      await ref.read(userDataProvider.notifier).updateUserData(userData);

      ref.read(signUpStepControllerProvider.notifier).next();
    } finally {
      await EasyLoading.dismiss();
    }
  }

  @override
  Future<void> onTapSignUp(
    WidgetRef ref, {
    required List<InterviewTopic> topics,
  }) async {
    try {
      await EasyLoading.show();

      final userData = ref.read(userDataProvider).requireValue!.copyWith(
        topicIds: [...topics.map((e) => e.id)],
      );

      await ref.read(userDataProvider.notifier).updateUserData(userData).then(
        (_) {
          const MainRoute().go(ref.context);
        },
      );
    } finally {
      await EasyLoading.dismiss();
    }
  }
}
