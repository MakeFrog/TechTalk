import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';

abstract interface class UserRepository {
  Future<Result<UserEntity>> createUser();

  Future<Result<UserEntity>> getUser([String? uid]);

  Future<Result<void>> updateUser(UserEntity data);

  Future<Result<void>> deleteUser();

  /// storage에 이미지 파일을 업로드하고 url를 리턴
  Future<Result<String>> uploadImgFileAndGetUrl(File imageFile);

  /// 닉네임 중복 여부
  Future<Result<bool>> isNicknameDuplicated(String nickname);
}
