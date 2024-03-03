import 'package:techtalk/features/user/user.dart';

abstract interface class UserLocalDataSource {
  ///
  /// 유저의 실전 면접 기록 존재 여부 (한번이라도 실전 면접을 진행한 유저인지)
  ///
  bool hasPracticalInterviewRecord();

  ///
  /// 유저의 로컬 정보 업데이트
  ///
  Future<void> storeUserLocalInfo(UserEntity user);

  ///
  /// 유저 로컬 데이터 로드
  ///
  UserBox loadUserLocalInfo();

  ///
  /// 유저 앱 평가 요청 가능 상태를 비활성화
  ///
  Future<void> disableReviewAvailableState();
}
