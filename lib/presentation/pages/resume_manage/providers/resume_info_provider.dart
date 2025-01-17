// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/user.dart';

part 'resume_info_provider.g.dart';

@Riverpod(keepAlive: true)
class ResumeInfo extends _$ResumeInfo {
  @override
  DocumentEntity build() {
    /// 로컬에서 DocumentEntity 불러오기
    final result = userRepository.loadDocumentData();
    return result.fold(
      onSuccess: (doc) => doc,
      onFailure: (e) {
        log('ResumeInfo DATA 실패: $e');
        return DocumentEntity(
          resume: ResumeEntity(),
          portfolio: PortfolioEntity(),
        );
      },
    );
  }

  ///
  /// 툴팁 활성화 조건
  ///
  bool showTooltip() {
    final resumePath = state.resume.path ?? '';
    final portfolioPath = state.portfolio.path ?? '';
    // “다르면 툴팁을 보이게 한다”는 로직
    return resumePath != portfolioPath;
  }

  ///
  /// 로컬 데이터 존재 유무 확인
  ///
  bool hasData() {
    return state.resume.path!.isNotEmpty || state.portfolio.path!.isNotEmpty;
  }

  ///
  /// 이력서 상태만 업데이트
  ///
  Future<void> updateResumeState(ResumeEntity newResume) async {
    state = state.copyWith(resume: newResume);
  }

  ///
  /// 이력서 데이터 업데이트
  ///
  Future<void> updateResumeData(ResumeEntity newResume) async {
    final storeResult = await userRepository.changeResumeData(newResume);
    storeResult.fold(
      onSuccess: (_) => null,
      onFailure: (e) {},
    );
  }

  ///
  /// 포트폴리오 상태만 업데이트
  ///
  Future<void> updatePortfolioState(PortfolioEntity newPortfolio) async {
    state = state.copyWith(portfolio: newPortfolio);
  }

  ///
  /// 포트폴리오 데이터 업데이트
  ///
  Future<void> updatePortfolioData(PortfolioEntity newPortfolio) async {
    final updated = state.copyWith(portfolio: newPortfolio);
    state = updated;

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
    state = state.copyWith(
      resume: ResumeEntity(),
      portfolio: PortfolioEntity(),
    );
  }
}
