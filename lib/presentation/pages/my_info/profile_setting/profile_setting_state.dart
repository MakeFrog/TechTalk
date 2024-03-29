import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/providers/picked_profile_img.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class ProfileSettingState {
  ///
  /// 이미지 파일
  ///
  File? pickedImgFile(WidgetRef ref) => ref.watch(pickedProfileImgProvider);

  ///
  /// 유저 정보
  ///
  UserEntity user(WidgetRef ref) => ref.watch(userInfoProvider).value!;

  AsyncValue<UserEntity?> userAsync(WidgetRef ref) =>
      ref.watch(userInfoProvider);

  ///
  /// 닉네임
  ///
  String? nickname(WidgetRef ref) => ref.watch(nicknameInputProvider);

  ///
  /// 프로필 이미지 변경 여부
  ///
  bool hasProfileImgEdited(WidgetRef ref) =>
      ref.watch(pickedProfileImgProvider) != null;

  ///
  /// 닉네임 변경 여부
  ///
  bool hasNicknameEdited(WidgetRef ref) {
    final prevNickname = ref.watch(userInfoProvider).value!.nickname;
    return prevNickname != ref.watch(nicknameInputProvider);
  }
}
