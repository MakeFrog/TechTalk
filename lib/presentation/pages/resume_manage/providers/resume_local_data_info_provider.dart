import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/user/user.dart';

part 'resume_local_data_info_provider.g.dart';

@Riverpod(keepAlive: true)
class ResumeLocalDataInfo extends _$ResumeLocalDataInfo {
  @override
  ResumeLocalState build() {
    // PDF 메타데이터를 가져와서 초기 상태를 설정
    final metadataResult = userRepository.getPdfMetaData();
    return metadataResult.fold(
      onSuccess: (metadata) => ResumeLocalState(
        localResumePath: metadata['resumePdfPath'],
        localResumeTitle: metadata['resumePdfTitle'],
        localResumeDate: metadata['resumePdfDate'],
        localPortfolioPath: metadata['portfolioPdfPath'],
        localPortfolioTitle: metadata['portfolioPdfTitle'],
        localPortfolioDate: metadata['portfolioPdfDate'],
      ),
      onFailure: (e) {
        log('Failed to load metadata: $e');
        return const ResumeLocalState(); // 기본 상태 반환
      },
    );
  }

  /// 로컬 데이터 불러오기
  Result<Map<String, String?>> getPdfMetaData() {
    try {
      return userRepository.getPdfMetaData();
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}

///
/// 이력서 관리 페이지에서만 사용될 로컬 데이터 저장 형태 정의 클래스
///
class ResumeLocalState {
  final String? localResumePath;
  final String? localResumeTitle;
  final String? localResumeDate;
  final String? localPortfolioPath;
  final String? localPortfolioTitle;
  final String? localPortfolioDate;

  const ResumeLocalState({
    this.localResumePath,
    this.localResumeTitle,
    this.localResumeDate,
    this.localPortfolioPath,
    this.localPortfolioTitle,
    this.localPortfolioDate,
  });

  ResumeLocalCopyWith get copyWith => _ResumeLocalStateCopyWith(this);
}

///
/// 클래스의 copywith에서 특정 값(not null)을 기본 값(null)으로 변경할 수 있도록 추상클래스 구현
///
abstract class ResumeLocalCopyWith {
  ResumeLocalState call({
    String? localResumePath,
    String? localResumeTitle,
    String? localResumeDate,
    String? localPortfolioPath,
    String? localPortfolioTitle,
    String? localPortfolioDate,
  });
}

class _ResumeLocalStateCopyWith implements ResumeLocalCopyWith {
  final ResumeLocalState value;
  static const Object _undefined = Object();

  const _ResumeLocalStateCopyWith(this.value);

  @override
  ResumeLocalState call({
    Object? localResumePath = _undefined,
    Object? localResumeTitle = _undefined,
    Object? localResumeDate = _undefined,
    Object? localPortfolioPath = _undefined,
    Object? localPortfolioTitle = _undefined,
    Object? localPortfolioDate = _undefined,
  }) {
    return ResumeLocalState(
      localResumePath: localResumePath == _undefined
          ? value.localResumePath
          : localResumePath as String?,
      localResumeTitle: localResumeTitle == _undefined
          ? value.localResumeTitle
          : localResumeTitle as String?,
      localResumeDate: localResumeDate == _undefined
          ? value.localResumeDate
          : localResumeDate as String?,
      localPortfolioPath: localPortfolioPath == _undefined
          ? value.localPortfolioPath
          : localPortfolioPath as String?,
      localPortfolioTitle: localPortfolioTitle == _undefined
          ? value.localPortfolioTitle
          : localPortfolioTitle as String?,
      localPortfolioDate: localPortfolioDate == _undefined
          ? value.localPortfolioDate
          : localPortfolioDate as String?,
    );
  }
}
