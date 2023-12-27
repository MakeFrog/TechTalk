import 'dart:io';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';

abstract interface class UserRepository {
  Future<Result<void>> createUserData();

  Future<Result<void>> updateUserData(UserDataEntity data);

  Future<Result<UserDataEntity?>> getUserData();

  Future<Result<void>> deleteUserData();

  Future<Result<List<String>>> getUserTopicIds();

  /// storage에 이미지 파일을 업로드하고 url를 리턴
  Future<Result<String>> uploadImgFileAndGetUrl(File imageFile);
}
