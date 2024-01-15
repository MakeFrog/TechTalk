part of 'sign_up_event.dart';

extension NicknameInputEvent on SignUpEvent {
  ///
  /// 닉네임이 입력되었을 때
  ///
  void onNicknameChanged(WidgetRef ref, {required String? input}) {
    return ref.read(nicknameInputProvider.notifier).onInputChanged(input);
  }

  ///
  /// 닉네임 입력창이 초기화 되었을 대
  ///
  void onClearNicknameField(WidgetRef ref) {
    ref.read(nicknameInputProvider.notifier).clearInput();
  }

  ///
  /// 닉네임 단계에서 '다음' 버튼이 클릭 되었을 때
  ///
  Future<void> onNicknameStepBtnTapped(WidgetRef ref) async {
    await EasyLoading.show();

    final editedNickname = ref.read(nicknameInputProvider);

    final checkDuplicationRes =
        await checkIsNicknameIsDuplicated.call(editedNickname!);

    checkDuplicationRes.fold(
      onSuccess: (isDuplicated) {
        if (isDuplicated) {
          SnackBarService.showSnackBar('중복된 닉네임 입니다');
          EasyLoading.dismiss();
        } else {
          ref.read(signUpStepControllerProvider.notifier).next();
          EasyLoading.dismiss();
        }
      },
      onFailure: (e) {
        EasyLoading.dismiss();
        SnackBarService.showSnackBar(e.toString());
        log(e.toString());
      },
    );
  }

  ///
  /// 닉네임 단계 유효성 검사
  ///
  String? nicknameValidation(WidgetRef ref, {required String? input}) {
    return ref.read(nicknameInputProvider.notifier).nickNameValidation(input);
  }
}
