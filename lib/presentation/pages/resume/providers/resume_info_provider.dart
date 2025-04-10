import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
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
      _isSameState = !isResumeChanged(newDoc) && !isPortfolioChanged(newDoc);
      debugPrint('이력서 파일에 변화가 있는가? : ${isResumeChanged(newDoc)}');
      debugPrint('포트폴리오 파일에 변화가 있는가? : ${isPortfolioChanged(newDoc)}');
      debugPrint('리슨중 - 파일에 변화가 있는가? ${!_isSameState}');
    });

    return doc;
  }

  ///
  /// 이력서 - 초기 상태와 현재 상태 비교
  ///
  bool isResumeChanged(DocumentEntity? newDoc) {
    final initResume = _initialResume;
    final newResume = newDoc?.resume;
    bool isResumeSame = (initResume == null && newResume == null) ||
        (initResume != null && initResume == newResume);

    return !isResumeSame;
  }

  ///
  /// 포트폴리오 - 초기 상태와 현재 상태 비교
  ///
  bool isPortfolioChanged(DocumentEntity? newDoc) {
    final initPortfolio = _initialPortfolio;
    final newPortfolio = newDoc?.portfolio;

    bool isPortfolioSame = (initPortfolio == null && newPortfolio == null) ||
        (initPortfolio != null && initPortfolio == newPortfolio);

    return !isPortfolioSame;
  }

  ///
  /// 저장하기 버튼 활성화 기준
  ///
  bool isStateChanged() => !_isSameState;

  ///
  /// Document 상태  확인
  ///
  bool hasDocument() => state.valueOrNull?.hasFetchedAnyDocuments ?? false;

  ///
  /// 이력서 상태 업데이트
  ///
  Future<void> updateResumeState(ResumeEntity? newResume) async {
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
  /// 문서 저장 로직
  ///
  Future<void> saveDocument() async {
    final doc = state.valueOrNull;
    if (doc == null) return;

    // 변경 여부 검사
    final resumeChanged = isResumeChanged(doc);
    final portfolioChanged = isPortfolioChanged(doc);

    // 병렬 실행을 위해 담아둘 Future 리스트
    final futures = <Future>[];

    if (resumeChanged) {
      futures.add(_saveResume(doc.resume));
    }

    if (portfolioChanged) {
      futures.add(_savePortfolio(doc.portfolio));
    }

    if (futures.isEmpty) {
      debugPrint('이력서/포트폴리오 모두 변경되지 않음');
      return;
    }

    await Future.wait(futures);
  }

  ///
  /// 이력서 상태가 변경되었을 때 실행
  ///
  Future<void> _saveResume(ResumeEntity? newResume) async {
    final stopwatch = Stopwatch()..start();
    debugPrint('이력서가 변경되어서 실행');
    await updateResume(newResume);
    stopwatch.stop();
    debugPrint('이력서 PDF 저장 소요시간 : ${stopwatch.elapsedMilliseconds} ms');
  }

  ///
  /// 포트폴리오 상태가 변경되었을 때 실행
  ///
  Future<void> _savePortfolio(PortfolioEntity? newPortfolio) async {
    final stopwatch = Stopwatch()..start();
    debugPrint('포트폴리오가 변경되어서 실행');
    await updatePortfolio(newPortfolio);
    stopwatch.stop();
    debugPrint('포트폴리오 PDF 저장 소요시간 : ${stopwatch.elapsedMilliseconds} ms');
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
