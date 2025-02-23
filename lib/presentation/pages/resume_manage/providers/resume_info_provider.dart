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
  @override
  FutureOr<DocumentEntity?> build() async {
    /// 로컬에서 DocumentEntity 불러오기
    final result = await userRepository.loadDocumentData();

    final doc = result.fold(
      onSuccess: (doc) => doc,
      onFailure: (e) => null,
    );

    return doc;
  }

  ///
  /// TODO: 임시 코드 (yundal)
  /// 저장하기 버튼 활성화 조건
  ///
  bool isStateChanged() {
    return true;
  }

  ///
  /// 로컬 데이터 존재 유무 확인
  ///
  bool hasData() {
    final doc = state.valueOrNull;

    if (doc == null) {
      return false;
    }

    return doc.resume != null || doc.portfolio != null;
  }

  ///
  /// 이력서 상태만 업데이트
  ///
  Future<void> updateResumeState(ResumeEntity? newResume) async {
    state = state.whenData((doc) {
      if (doc == null) return null;

      debugPrint('updateResumeState - newResume : $newResume');

      return newResume == null
          ? doc.deleteResume()
          : doc.copyWith(resume: newResume);
    });
  }

  ///
  /// 이력서 데이터 업데이트
  ///
  Future<void> updateResumeData(ResumeEntity? newResume) async {
    debugPrint('newResume 객체 : $newResume');
    debugPrint('newResume 경로 : ${newResume?.path}');
    debugPrint('newResume 제목 : ${newResume?.title}');

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
    state = state.whenData((doc) {
      if (doc == null) return null;

      debugPrint('updateResumeState - newPortfolio : $newPortfolio');

      return newPortfolio == null
          ? doc.deletePortfolio()
          : doc.copyWith(portfolio: newPortfolio);
    });
  }

  ///
  /// 포트폴리오 데이터 업데이트
  ///
  Future<void> updatePortfolioData(PortfolioEntity? newPortfolio) async {
    debugPrint('newPortfolio 객체 : $newPortfolio');
    debugPrint('newPortfolio 경로 : ${newPortfolio?.path}');
    debugPrint('newPortfolio 제목 : ${newPortfolio?.title}');

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
