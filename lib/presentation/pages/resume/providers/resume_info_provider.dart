import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/features/user/user.dart';

part 'resume_info_provider.g.dart';

@Riverpod()
class ResumeInfo extends _$ResumeInfo {
  @override
  FutureOr<DocumentEntity?> build() async {
    final result = await userRepository.loadDocumentData();

    final doc = result.fold(
      onSuccess: (doc) => doc,
      onFailure: (e) => null,
    );

    return doc;
  }

  ///
  /// 저장하기 버튼 활성화 기준
  ///
  bool isFileChanged() {
    final doc = state.valueOrNull;
    return doc?.isFileChanged ?? false;
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
  /// 이력서, 포트폴리오 상태 업데이트
  ///
  Future<void> updateDocumentState(DocumentType type, dynamic newData) async {
    state = state.whenData((doc) {
      if (doc == null) return null;

      doc.isFileChanged = true;

      // 이력서 상태 업데이트
      if (type == DocumentType.resume) {
        ResumeEntity? newResume = newData as ResumeEntity?;

        return newResume == null
            ? doc.deleteResume()
            : doc.copyWith(resume: newResume);
      }

      // 포트폴리오 상태 업데이트
      else {
        PortfolioEntity? newPortfolio = newData as PortfolioEntity?;

        return newPortfolio == null
            ? doc.deletePortfolio()
            : doc.copyWith(portfolio: newPortfolio);
      }
    });
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

    // 모든 저장 로직이 끝나면 다시 파일 변경 false
    doc.isFileChanged = false;
  }

  ///
  /// 사용자가 이력서/포트폴리오 중 하나를 최초 등록했을 때 툴팁 보여주는 로직
  ///
  Future<void> showTooltip() async {
    final doc = state.valueOrNull;
    if (doc == null) {
      return;
    }

    // 현재 DocumentEntity가 가진 파일 개수 확인
    final int docCount =
        (doc.resume != null ? 1 : 0) + (doc.portfolio != null ? 1 : 0);

    // 파일이 정확히 1개일 때만 툴팁을 true로 설정, 그 외(0개 or 2개 이상)는 false
    final bool shouldShow = (docCount == 1);

    // state를 업데이트하여 shouldShowTooltip 반영
    state = state.whenData((oldDoc) {
      if (oldDoc == null) return null;

      // docCount == 1이면 true, 아니면 false
      return oldDoc.copyWith(shouldShowTooltip: shouldShow);
    });
  }
}
