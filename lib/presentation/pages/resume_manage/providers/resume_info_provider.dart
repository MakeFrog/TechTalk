// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/rendering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/user.dart';

part 'resume_info_provider.g.dart';

@Riverpod()
class ResumeInfo extends _$ResumeInfo {
  // build()에서 불러온 로컬 데이터를 저장해둘 필드
  late final DocumentEntity? _localDoc;

  @override
  FutureOr<DocumentEntity?> build() async {
    /// 로컬에서 DocumentEntity 불러오기
    final result = await userRepository.loadDocumentData();

    final doc = result.fold(
      onSuccess: (doc) => doc,
      onFailure: (e) => null,
    );

    // 빌드 시점에 불러온 로컬 데이터를 캐싱
    _localDoc = doc;
    return doc;
  }

  ///
  /// 저장하기 버튼 활성화 조건
  ///
  bool isStateChanged() {
    // 임시 코드
    return true;
  }

  ///
  /// 로컬 데이터 존재 유무 확인
  ///
  bool hasData() {
    if (_localDoc == null) {
      return false;
    }

    return _localDoc!.resume != null || _localDoc!.portfolio != null;
  }

  ///
  /// 이력서 상태만 업데이트
  ///
  Future<void> updateResumeState(ResumeEntity? newResume) async {
    state = state.whenData((doc) => doc?.copyWith(resume: newResume));
  }

  ///
  /// 이력서 데이터 업데이트
  ///
  Future<void> updateResumeData(ResumeEntity? newResume) async {
    debugPrint('newResume : ${newResume?.path}');
    debugPrint('newResume : ${newResume?.title}');

    final storeResult = await userRepository.changeResumeData(newResume);
    storeResult.fold(
      onSuccess: (_) => null,
      onFailure: (e) {},
    );
  }

  ///
  /// 포트폴리오 상태만 업데이트
  ///
  Future<void> updatePortfolioState(PortfolioEntity? newPortfolio) async {
    state = state.whenData((doc) => doc?.copyWith(portfolio: newPortfolio));
  }

  ///
  /// 포트폴리오 데이터 업데이트
  ///
  Future<void> updatePortfolioData(PortfolioEntity? newPortfolio) async {
    final storeResult = await userRepository.changePortfolioData(newPortfolio);
    storeResult.fold(
      onSuccess: (_) => null,
      onFailure: (e) {},
    );
  }

  ///
  /// 상태 초기화
  ///
  Future<void> resetState() async {
    state = state.whenData((doc) {
      final newDoc = doc?.copyWith(
            resume: ResumeEntity(),
            portfolio: PortfolioEntity(),
          ) ??
          DocumentEntity(resume: ResumeEntity(), portfolio: PortfolioEntity());
      return newDoc;
    });
  }
}
