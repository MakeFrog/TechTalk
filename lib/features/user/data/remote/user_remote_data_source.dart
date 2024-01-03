import 'package:techtalk/features/user/data/models/user_model.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  /// 유저 데이터를 생성한다.
  ///
  /// 새로 만들어진 [UserModel]을 반환한다.
  Future<UserModel> createUser();

  /// [uid]와 일치하는 uid를 가지는 유저 데이터를 조회한다.
  ///
  /// [uid]가 null이라면 현재 로그인되어있는 유저의 uid로 조회한다.
  /// 조회된 데이터를 반환한다.
  Future<UserModel> getUser([String? uid]);

  /// [data.uid]와 일치하는 uid를 가지는 유저 데이터를 업데이트한다.
  Future<void> updateUser(UserEntity data);

  /// 현재 로그인되어있는 유저 데이터를 삭제한다.
  Future<void> deleteUser();
}
