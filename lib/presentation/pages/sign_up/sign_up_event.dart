import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/helper/validation_extension.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/provider/selected_job_groups_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/selected_skills_provider.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/skill_input_provider.dart';
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
    } else if (nickname.containsBadWords) {
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
    WidgetRef ref,
  ) async {
    try {
      final jobGroups = ref.read(selectedJobGroupsProvider);

      FocusManager.instance.primaryFocus?.unfocus();

      await EasyLoading.show();
      final userData = ref.read(userDataProvider).requireValue!.copyWith(
        jobGroups: [...jobGroups.map((e) => JobGroup.getById(e.id))],
      );

      await ref.read(userDataProvider.notifier).updateData(userData);

      ref.read(signUpStepControllerProvider.notifier).next();
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onTapSignUp(WidgetRef ref) async {
    try {
      await EasyLoading.show();
      final selectedSkills = ref.watch(selectedSkillsProvider);

      final userData = ref.read(userDataProvider).requireValue!.copyWith(
            skills: selectedSkills,
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

  ///
  /// 직군 ListTile이 클릭되었을 때
  ///
  void onJobGroupListTileTapped(WidgetRef ref, {required JobGroup item}) {
    final selectedJobGroups = ref.read(selectedJobGroupsProvider);
    if (selectedJobGroups.contains(item)) {
      ref.read(selectedJobGroupsProvider.notifier).remove(item);
    } else {
      ref.read(selectedJobGroupsProvider.notifier).add(item);
    }
  }

  ///
  /// 선택된 직군 Chip 위젯이 클릭 되었을 때
  ///
  void onJogGroupChipTapped(WidgetRef ref, {required JobGroup item}) {
    ref.read(selectedJobGroupsProvider.notifier).remove(item);
  }

  ///
  /// 닉네임 유효성 검사
  ///
  String? skillInputValidation(WidgetRef ref,
          {required String? searchedTerm}) =>
      ref.read(skillInputProvider.notifier).skillInputValidation(searchedTerm);

  ///
  /// 닉네임필드에 값이 clear 되었을 때
  ///
  void onSkillFieldCloseBtnTapped(WidgetRef ref) {
    ref.read(skillInputProvider.notifier).clear();
    ref.read(searchedSkillsProvider.notifier).clear();
  }

  ///
  /// 검색된 스킬 리스트 호출
  /// TextField 값 업데이트
  ///
  void onSkillFiledChanged(WidgetRef ref, {required String searchedTerm}) {
    ref.read(searchedSkillsProvider.notifier).updateSearchedList(searchedTerm);
    ref.read(skillInputProvider.notifier).update(searchedTerm);
  }
}
