import 'dart:async';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/providers/picked_profile_img.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

mixin class ProfileSettingEvent {
  ///
  /// 프로필 이미지 탭 되었을 때
  ///
  void onProfileImgTapped(WidgetRef ref) async {
    await EasyLoading.show();
    unawaited(
      ref
          .read(pickedProfileImgProvider.notifier)
          .pickImageFile()
          .whenComplete(EasyLoading.dismiss),
    );
  }

  ///
  /// 닉네임 유효성 검사
  ///
  String? nicknameValidation(WidgetRef ref, {required String? input}) {
    return ref.read(nicknameInputProvider.notifier).nickNameValidation(input);
  }

  ///
  /// 닉네임이 입력되었을 때
  ///
  void onNicknameChanged(WidgetRef ref, {required String? input}) {
    return ref.read(nicknameInputProvider.notifier).onInputChanged(input);
  }

  ///
  /// 닉네임필드에 값이 clear 되었을 때
  ///
  void onNicknameFieldClear(WidgetRef ref) {
    ref.read(nicknameInputProvider.notifier).clearInput();
  }

  ///
  /// 저장하기 버튼이 클릭 되었을 떄
  ///
  Future<void> onSaveBtnTapped(WidgetRef ref) async {
    await EasyLoading.show();
    final editedNickname = ref.read(nicknameInputProvider);
    final profileImgFile = ref.read(pickedProfileImgProvider);

    final user =
        ref.read(userDataProvider).value!.copyWith(nickname: editedNickname);

    final response = await editUserProfileUseCase
        .call((user: user, imageFile: profileImgFile));

    response.fold(
      onSuccess: (userRes) {
        EasyLoading.dismiss();
        ref.read(userDataProvider.notifier).edit(userRes);
        ref.context.pop();
        SnackBarService.showSnackBar('프로필 정보를 업데이트 했습니다');
      },
      onFailure: (e) {
        EasyLoading.dismiss();
        ref.context.pop();
        SnackBarService.showSnackBar('프로필 정보를 업데이트하지 못했습니다');
        log('e');
      },
    );
  }
}
