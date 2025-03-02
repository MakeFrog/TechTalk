import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserLocalDataSource {
  ///
  /// 유저의 로컬 정보 업데이트
  ///
  Future<void> storeUserLocalInfo(UserEntity user);

  ///
  /// 면접을 처음 실행했는지 여부 값 업데이트
  ///
  Future<void> changeFirstEnteredFieldToTrue();

  ///
  /// 유저 로컬 데이터 로드
  ///
  UserBox loadUserLocalInfo();

  ///
  /// 유저 앱 평가 요청 가능 상태를 비활성화
  ///
  Future<void> disableReviewAvailableState();

  ///
  /// 유저 이력서 데이터 저장
  ///
  Future<void> changeResumeData(ResumeEntity? resume);

  ///
  /// 유저 포트폴리오 데이터 저장
  ///
  Future<void> changePortfolioData(PortfolioEntity? portfolio);
}
