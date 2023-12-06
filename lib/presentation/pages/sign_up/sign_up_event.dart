import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/skill/skill.dart';
import 'package:techtalk/presentation/providers/sign_up/sign_up_form_provider.dart';
import 'package:techtalk/presentation/providers/sign_up/sign_up_step_controller.dart';

abstract class _SignUpEvent {
  /// 앱바의 [BackButton]을 눌렀을 때 실행할 콜백
  ///
  /// 이전 회원가입 단계로 넘어간다. 이전 단계로 넘어갈 시 현재 단계에 작성한 데이터는 삭제한다.
  void onTapBackButton(WidgetRef ref);

  /// 닉네임 입력 스크린의 다음단계 버튼을 눌렀을 때 실행할 콜백
  Future<void> onTapNicknameStepNext(
    WidgetRef ref, {
    required String nickname,
  });

  void onTapSelectedJobGroup(
    WidgetRef ref, {
    required JobGroupEntity group,
  });

  void onTapJobGroup(
    WidgetRef ref, {
    required JobGroupEntity group,
  });

  void onTapJobGroupStepNext(WidgetRef ref);

  void onTapSelectedSkill(
    WidgetRef ref, {
    required SkillEntity skill,
  });

  void onTapSkill(
    WidgetRef ref, {
    required SkillEntity skill,
    required TextEditingController controller,
  });

  Future<void> onTapSignUp(WidgetRef ref);
}

mixin class SignUpEvent implements _SignUpEvent {
  @override
  void onTapBackButton(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).prev();
  }

  @override
  Future<void> onTapNicknameStepNext(
    WidgetRef ref, {
    required String nickname,
  }) async {
    //? 현재는 컨트롤러 값만 바뀌주고있음
    //? 단계 변경 전 닉네임 검사를 한번 더 할지, 닉네임 검사를 끝내면 임시로 닉네임을 점유할지 등 고민 필요

    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(signUpFormProvider.notifier).updateNickname(nickname);
    ref.read(signUpStepControllerProvider.notifier).next();
  }

  @override
  void onTapJobGroup(
    WidgetRef ref, {
    required JobGroupEntity group,
  }) {
    final jobGroupList = ref.read(
      signUpFormProvider.select((v) => v.jobGroups ?? []),
    );

    if (jobGroupList.contains(group)) {
      ref.read(signUpFormProvider.notifier).removeJobGroup(group);
    } else {
      ref.read(signUpFormProvider.notifier).addJobGroup(group);
    }
  }

  @override
  void onTapSelectedJobGroup(
    WidgetRef ref, {
    required JobGroupEntity group,
  }) {
    ref.read(signUpFormProvider.notifier).removeJobGroup(group);
  }

  @override
  void onTapJobGroupStepNext(WidgetRef ref) {
    //? 현재는 컨트롤러 값만 바뀌주고있음
    //? 단계 변경 전 닉네임 검사를 한번 더 할지, 닉네임 검사를 끝내면 임시로 닉네임을 점유할지 등 고민 필요

    ref.read(signUpStepControllerProvider.notifier).next();
  }

  @override
  void onTapSelectedSkill(
    WidgetRef ref, {
    required SkillEntity skill,
  }) {
    ref.read(signUpFormProvider.notifier).removeSkill(skill);
  }

  @override
  void onTapSkill(
    WidgetRef ref, {
    required TextEditingController controller,
    required SkillEntity skill,
  }) {
    final selectedSkills = ref.read(
      signUpFormProvider.select((v) => v.skills ?? []),
    );

    if (!selectedSkills.contains(skill)) {
      ref.read(signUpFormProvider.notifier).addSkill(skill);
    }
    controller.clear();
  }

  @override
  Future<void> onTapSignUp(WidgetRef ref) async {
    try {
      await EasyLoading.show()
          .then(
        (_) => ref.read(signUpFormProvider.notifier).submit(),
      )
          .then(
        (_) {
          const MainRoute().go(ref.context);
        },
      ).whenComplete(
        EasyLoading.dismiss,
      );
    } catch (e) {}
  }
}
