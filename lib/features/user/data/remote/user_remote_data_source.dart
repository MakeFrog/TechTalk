import 'dart:io';

import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUserData();

  Future<void> updateUserData(UserDataEntity data);

  Future<UserDataEntity> getUserData();

  Future<void> deleteUserData();

  Future<bool> isExistNickname(String nickname);

  /// storage에 이미지 파일을 업로드하고 url를 리턴
  Future<String> uploadImgFileAndGetUrl(File imageFile);
}
