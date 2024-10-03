import 'dart:io';

import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';

abstract interface class UserRepository {
  ///
  /// 유저 정보 생성
  ///
  Future<Result<void>> createUser(UserEntity data);

  ///
  /// 유저의 면접 실행 기록 여부
  ///
  Result<bool> hasEnteredFirstInterview();

  ///
  /// 유저 정보 호출
  ///
  Future<Result<UserEntity>> getUser([String? uid]);

  ///
  /// 유저 정보 업데이트
  ///
  Future<Result<void>> updateUser(UserEntity data);

  ///
  /// 유저 정보 삭제
  ///
  Future<Result<void>> deleteUser(UserEntity user);

  ///
  /// storage에 이미지 파일을 업로드하고 url를 리턴
  ///
  Future<Result<String>> uploadImgFileAndGetUrl(File imageFile);

  ///
  /// 닉네임 중복 여부
  ///
  Future<Result<bool>> isNicknameDuplicated(String nickname);

  ///
  /// 면접 기록 존재 여부 필드 값 업데이트
  ///
  Future<Result<void>> storeUserLocalInfo(UserEntity user);

  ///
  /// 마지막 접속 일자 갱신
  ///
  Future<Result<void>> updateLastLoginDate();

  ///
  /// 완료된 면접 개수 필드 증가 및 값 리턴
  ///
  Future<Result<int>> increaseCompletedInterviewCount();

  ///
  /// 유저 앱 평가 요청 가능 상태를 비활성화
  ///
  Future<Result<void>> disableReviewAvailableState();

  ///
  /// 면접을 처음 실행했는지 여부 값 업데이트
  ///
  Future<Result<void>> changeFirstEnteredFieldToTrue();
}
