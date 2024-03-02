import 'dart:io';

import 'package:techtalk/features/user/data_source/remote/models/user_model.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  /// 유저 데이터를 생성한다.
  Future<void> createUser(UserEntity data);

  /// [data.uid]와 일치하는 uid를 가지는 유저 데이터를 업데이트한다.
  Future<void> updateUser(UserEntity data);

  /// [uid]와 일치하는 uid를 가지는 유저 데이터를 조회한다.
  ///
  /// [uid]가 null이라면 현재 로그인되어있는 유저의 uid로 조회한다.
  /// 조회된 데이터를 반환한다.
  Future<UserModel> getUser([String? uid]);

  ///
  /// 회원탈퇴
  ///
  Future<void> resign(UserModel user);

  Future<bool> isExistNickname(String nickname);

  /// storage에 이미지 파일을 업로드하고 url를 리턴
  Future<String> uploadImgFileAndGetUrl(File imageFile);

  ///
  /// 마지막 접속 일자 갱신
  ///
  Future<void> updateLastLoginDate();

  ///
  /// 완료된 면접 개수 필드 증가 및 값 리턴
  ///
  Future<int> increaseCompletedInterviewCount();
}
