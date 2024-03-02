import 'dart:io';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Result<void>> createUser(UserEntity data);
  Future<Result<UserEntity>> getUser([String? uid]);
  Future<Result<void>> updateUser(UserEntity data);
  Future<Result<void>> quitUser(UserEntity user);

  /// storage에 이미지 파일을 업로드하고 url를 리턴
  Future<Result<String>> uploadImgFileAndGetUrl(File imageFile);

  /// 닉네임 중복 여부
  Future<Result<bool>> isNicknameDuplicated(String nickname);

  /// 면접 기록 존재 여부 필드 값 업데이트
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
}
