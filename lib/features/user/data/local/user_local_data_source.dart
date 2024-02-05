import 'package:techtalk/features/user/entities/user_entity.dart';

abstract interface class UserLocalDataSource {
  ///
  /// 유저의 실전 면접 기록 존재 여부 (한번이라도 실전 면접을 진행한 유저인지)
  ///
  bool hasPracticalInterviewRecord();

  ///
  /// 유저의 로컬 정보 업데이트
  ///
  Future<void> storeUserLocalInfo(UserEntity user);
}
