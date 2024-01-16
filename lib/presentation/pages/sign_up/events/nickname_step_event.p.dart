part of 'sign_up_event.dart';

extension NicknameStepEvent on SignUpEvent {
  ///
  /// 닉네임이 입력되었을 때
  ///
  void onNicknameFieldChanged(WidgetRef ref, {required String? input}) {
    return ref.read(nicknameInputProvider.notifier).onInputChanged(input);
  }

  ///
  /// 닉네임 유효성 검사
  ///
  String? nicknameValidation(WidgetRef ref, {required String? input}) {
    return ref.read(nicknameInputProvider.notifier).nickNameValidation(input);
  }

  ///
  /// 닉네임필드에 값이 clear 되었을 때
  ///
  void onNicknameFieldClear(WidgetRef ref) {
    ref.read(nicknameInputProvider.notifier).clearInput();
  }

  ///
  /// 닉네임 단계에서 '다음' 버튼이 클릭 되었을 때
  ///
  Future<void> onNicknameStepBtnTapped(WidgetRef ref) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await EasyLoading.show();

    final editedNickname = ref.read(nicknameInputProvider);

    final checkDuplicationRes =
        await checkIsNicknameIsDuplicated.call(editedNickname!);

    checkDuplicationRes.fold(
      onSuccess: (isDuplicated) {
        EasyLoading.dismiss();
        if (isDuplicated) {
          SnackBarService.showSnackBar('중복된 닉네임 입니다');
        } else {
          ref.read(signUpStepControllerProvider.notifier).next();
        }
      },
      onFailure: (e) {
        EasyLoading.dismiss();
        SnackBarService.showSnackBar('프로필 정보를 업데이트하지 못했습니다');
        log(e.toString());
      },
    );
  }
}
