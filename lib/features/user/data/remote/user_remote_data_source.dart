import 'dart:io';

import 'package:techtalk/features/user/data/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUserData(String uid);

  Future<void> updateUserData(UserDataEntity data);

  Future<UserDataModel?> getUserData(String uid);

  Future<void> deleteUserData(String uid);

  /// storage에 이미지 파일을 업로드하고 url를 리턴
  Future<String> uploadImgFileAndGetUrl(File imageFile);
}
