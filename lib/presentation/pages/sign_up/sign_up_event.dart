import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/job/entities/job_group_entity.dart';
import 'package:techtalk/features/skill/skill.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/searched_tech_skill_list_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller_provider.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

abstract class _SignUpEvent {
  /// 앱바의 [BackButton]을 눌렀을 때 실행할 콜백
  ///
  /// 이전 회원가입 단계로 넘어간다. 이전 단계로 넘어갈 시 현재 단계에 작성한 데이터는 삭제한다.
  void onTapBackButton(WidgetRef ref);

  /// 닉네임 필드가 변경될 떄마다 실행할 콜백
  ///
  /// 로딩 인디케이터 표시를 위해 [isRunningDebouncer]를 콜백 시작과 끝에 변경한다.
  /// [debouncer]를 통헤 여러번 입력하더라도 마지막 입력만 검사하도록 제한한다.
  Future<void> onChangeNicknameField(
    WidgetRef ref, {
    required String nickname,
    required ValueNotifier<bool> isRunningDebouncer,
  });

  /// 닉네임 필드의 클리어 아이콘을 눌렀을 때 실행할 콜백
  ///
  /// [controller]에 입력된 텍스트와 닉네임 데이터를 초기화한다.
  void onClearNicknameField(
    WidgetRef ref, {
    required ValueNotifier<bool> isRunningDebouncer,
  });

  /// 닉네임 입력 스크린의 다음단계 버튼을 눌렀을 때 실행할 콜백
  Future<void> onTapNicknameStepNext(WidgetRef ref);

  void onTapSelectedJobGroup(
    WidgetRef ref, {
    required JobGroupEntity group,
  });

  void onTapJobGroupListTile(
    WidgetRef ref, {
    required JobGroupEntity group,
  });

  void onTapJobGroupStepNext(WidgetRef ref);

  void onTapSelectedTechSkill(
    WidgetRef ref, {
    required SkillEntity skill,
  });

  void onChangeTechSkillSearchField(
    WidgetRef ref, {
    required String keyword,
  });

  void onClearTechSkillSearchField(
    WidgetRef ref, {
    required TextEditingController controller,
  });

  void onTapTechSkillListTile(
    WidgetRef ref, {
    required SkillEntity skill,
    required TextEditingController controller,
  });

  Future<void> onTapTechSkillStepNext(WidgetRef ref);
}

mixin class SignUpEvent implements _SignUpEvent {
  static final _nicknameValidateDebouncer = Debouncer(1.seconds);

  @override
  void onTapBackButton(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).prev();
    // TODO : 단계별 데이터 삭제 로직
    final stepController = ref.read(signUpStepControllerProvider);
    switch (stepController.page!.toInt()) {
      case 1:
        {}
      case 2:
        {}
    }
  }

  @override
  Future<void> onChangeNicknameField(
    WidgetRef ref, {
    required String nickname,
    required ValueNotifier<bool> isRunningDebouncer,
  }) async {
    // 입력받은 nickname이 비어있다면 콜백을 중단하고 닉네임 데이터를 초기화한다.
    if (nickname.isEmpty) {
      isRunningDebouncer.value = false;
      _nicknameValidateDebouncer.reset();
      await ref.read(signUpFormProvider.notifier).updateNickname(nickname);
    } else {
      isRunningDebouncer.value = true;

      _nicknameValidateDebouncer.call(
        () async {
          await ref.read(signUpFormProvider.notifier).updateNickname(nickname);

          isRunningDebouncer.value = false;
        },
      );
    }
  }

  @override
  void onClearNicknameField(
    WidgetRef ref, {
    required ValueNotifier<bool> isRunningDebouncer,
  }) {
    isRunningDebouncer.value = false;
    _nicknameValidateDebouncer.reset();

    ref.read(signUpFormProvider.notifier).updateNickname('');
  }

  @override
  Future<void> onTapNicknameStepNext(WidgetRef ref) async {
    //? 현재는 컨트롤러 값만 바뀌주고있음
    //? 단계 변경 전 닉네임 검사를 한번 더 할지, 닉네임 검사를 끝내면 임시로 닉네임을 점유할지 등 고민 필요

    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(signUpStepControllerProvider.notifier).next();
  }

  @override
  void onTapJobGroupListTile(
    WidgetRef ref, {
    required JobGroupEntity group,
  }) {
    final jobGroupList = ref.read(
      signUpFormProvider.select((v) => v.jobGroupList),
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
  void onTapSelectedTechSkill(
    WidgetRef ref, {
    required SkillEntity skill,
  }) {
    ref.read(signUpFormProvider.notifier).removeTechSkill(skill);
  }

  @override
  void onChangeTechSkillSearchField(
    WidgetRef ref, {
    required String keyword,
  }) {
    ref.read(techSkillSearchKeywordProvider.notifier).keyword = keyword;
  }

  @override
  void onClearTechSkillSearchField(
    WidgetRef ref, {
    required TextEditingController controller,
  }) {
    ref.invalidate(techSkillSearchKeywordProvider);
    controller.clear();
  }

  @override
  void onTapTechSkillListTile(
    WidgetRef ref, {
    required TextEditingController controller,
    required SkillEntity skill,
  }) {
    final techSkillList = ref.read(
      signUpFormProvider.select((v) => v.techSkillList),
    );

    if (!techSkillList.contains(skill)) {
      ref.read(signUpFormProvider.notifier).addTechSkill(skill);
    }
    controller.clear();
    ref.invalidate(techSkillSearchKeywordProvider);
  }

  @override
  Future<void> onTapTechSkillStepNext(WidgetRef ref) async {
    try {
      await EasyLoading.show()
          .then(
            (_) => ref.read(signUpFormProvider.notifier).submit(),
          )
          .then(
            (_) => ref.refresh(appUserDataProvider.future),
          )
          .then(
        (value) {
          if (value == null || !value.isCompleteSignUp) {
            throw Exception('회원가입 실패');
          }

          const MainRoute().go(ref.context);
        },
      ).whenComplete(
        EasyLoading.dismiss,
      );
    } on Exception catch (e) {}
  }
}
