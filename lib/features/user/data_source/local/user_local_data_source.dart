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
  /// 로컬 이력서 PDF 메타데이터 저장
  ///
  Future<void> storeResumePdfMetaData({
    required String? localResumePath,
    required String? localResumeTitle,
    required String? localResumeDate,
  });

  ///
  /// 로컬 포트폴리오 PDF 메타데이터 저장
  ///
  Future<void> storePortfolioPdfMetaData({
    required String? localPortfolioPath,
    required String? localPortfolioTitle,
    required String? localPortfolioDate,
  });
}
