import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/features/user/user.dart';

part 'resume_info_provider.g.dart';

@Riverpod()
class ResumeInfo extends _$ResumeInfo {
  // 초기 상태
  ResumeEntity? _initialResume;
  PortfolioEntity? _initialPortfolio;
  bool _isSameState = true;

  @override
  FutureOr<DocumentEntity?> build() async {
    final result = await userRepository.loadDocument();

    final doc = result.fold(
      onSuccess: (doc) => doc,
      onFailure: (e) => null,
    );

    _initialResume = doc?.resume;
    _initialPortfolio = doc?.portfolio;

    ref.listenSelf((previous, next) {
      final newDoc = next.value;
      _compareWithInitialData(newDoc);
    });

    return doc;
  }

  ///
  /// 초기 상태와 현재 상태 비교
  ///
  void _compareWithInitialData(DocumentEntity? newDoc) {
    // 초기 상태
    final initResume = _initialResume;
    final initPortfolio = _initialPortfolio;

    // 최종 상태
    final newResume = newDoc?.resume;
    final newPortfolio = newDoc?.portfolio;

    // 비교
    final sameResume = (initResume == null && newResume == null) ||
        (initResume != null && initResume == newResume);

    final samePortfolio = (initPortfolio == null && newPortfolio == null) ||
        (initPortfolio != null && initPortfolio == newPortfolio);

    _isSameState = sameResume && samePortfolio;

    // 디버그 로그
    debugPrint('resume 변동 여부: ${!sameResume}');
    debugPrint('portfolio 변동 여부: ${!samePortfolio}');
    debugPrint('결과적으로 _isSameState : $_isSameState');
  }

  ///
  /// 저장하기 버튼 활성화 기준
  ///
  bool isFileChanged() => !_isSameState;

  ///
  /// Document 상태  확인
  ///
  bool hasDocument() => state.valueOrNull?.hasFetchedAnyDocuments ?? false;

  ///
  /// 이력서 상태 업데이트
  ///
  Future<void> updateResumeState(
    DocumentType type,
    ResumeEntity? newResume,
  ) async {
    state = state.whenData(
      (doc) {
        // doc이 null이면 새 DocumentEntity 생성
        doc ??= DocumentEntity(resume: null, portfolio: null);

        DocumentEntity newDoc;

        newDoc = (newResume == null)
            ? doc.deleteResume()
            : doc.copyWith(resume: newResume);

        return newDoc;
      },
    );
  }

  ///
  /// 포트폴리오 상태 업데이트
  ///
  Future<void> updatePortfolioState(
    DocumentType type,
    PortfolioEntity? newPortfolio,
  ) async {
    state = state.whenData(
      (doc) {
        // doc이 null이면 새 DocumentEntity 생성
        doc ??= DocumentEntity(resume: null, portfolio: null);

        DocumentEntity newDoc;

        newDoc = (newPortfolio == null)
            ? doc.deletePortfolio()
            : doc.copyWith(portfolio: newPortfolio);

        return newDoc;
      },
    );
  }

  ///
  /// 이력서 데이터 업데이트
  ///
  Future<void> updateResume(ResumeEntity? newResume) async {
    // 로컬 데이터
    final result = await userRepository.updateResume(newResume);
    result.fold(
      onSuccess: (_) => null,
      onFailure: (e) {},
    );
  }

  ///
  /// 포트폴리오 데이터 업데이트
  ///
  Future<void> updatePortfolio(PortfolioEntity? newPortfolio) async {
    // 로컬 데이터
    final result = await userRepository.updatePortfolio(newPortfolio);
    result.fold(
      onSuccess: (_) => null,
      onFailure: (e) {},
    );
  }

  ///
  /// 실제 저장 로직(Repository 호출)을 모아서 수행하고,
  /// 저장이 완료되면 _isFileChanged = false 로 변경
  ///
  Future<void> saveDocument() async {
    final doc = state.valueOrNull;
    if (doc == null) return;

    // 각각 서버나 로컬에 저장
    await updateResume(doc.resume);
    await updatePortfolio(doc.portfolio);
  }

  ///
  /// 사용자가 이력서/포트폴리오 중 하나를 최초 등록했을 때 툴팁 보여주는 로직
  ///
  bool showTooltip() {
    final doc = state.valueOrNull;
    if (doc == null) {
      return false;
    }

    final int docCount =
        (doc.resume != null ? 1 : 0) + (doc.portfolio != null ? 1 : 0);

    final bool shouldShow = (docCount == 1);

    return shouldShow;
  }
}
