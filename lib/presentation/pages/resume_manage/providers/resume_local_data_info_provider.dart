// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/foundation.dart';
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
        localResumePath: metadata['resumePdfPath'] ?? '',
        localResumeTitle: metadata['resumePdfTitle'] ?? '',
        localResumeDate: metadata['resumePdfDate'] ?? '',
        localPortfolioPath: metadata['portfolioPdfPath'] ?? '',
        localPortfolioTitle: metadata['portfolioPdfTitle'] ?? '',
        localPortfolioDate: metadata['portfolioPdfDate'] ?? '',
      ),
      onFailure: (e) {
        log('Failed to load metadata: $e');
        return const ResumeLocalState(); // 기본 상태 반환
      },
    );
  }

  ///
  /// 이력서 PDF 정보 로컬 업데이트
  ///
  void updateLocalResume(
    String localResumePath,
    String localResumeTitle,
    String localResumeDate,
  ) {
    debugPrint('로컬 이력서 업데이트');
    // 1) Riverpod State 갱신
    state = state.copyWith(
      localResumePath: localResumePath,
      localResumeTitle: localResumeTitle,
      localResumeDate: localResumeDate,
    );

    // 2) user_box 갱신 (UserRepository 통해서 처리)
    //    - UserRepositoryImpl -> UserLocalDataSource -> Hive
    userRepository.storeResumePdfMetaData(
      localResumePath: localResumePath,
      localResumeTitle: localResumeTitle,
      localResumeDate: localResumeDate,
    );
  }

  ///
  /// 포트폴리오 PDF 정보 로컬 업데이트
  ///
  void updateLocalPortfolio(
    String localPortfolioPath,
    String localPortfolioTitle,
    String localPortfolioDate,
  ) {
    debugPrint('로컬 포트폴리오 업데이트');
    // 1) Riverpod State 갱신
    state = state.copyWith(
      localPortfolioPath: localPortfolioPath,
      localPortfolioTitle: localPortfolioTitle,
      localPortfolioDate: localPortfolioDate,
    );

    // 2) user_box 갱신
    userRepository.storePortfolioPdfMetaData(
      localPortfolioPath: localPortfolioPath,
      localPortfolioTitle: localPortfolioTitle,
      localPortfolioDate: localPortfolioDate,
    );
  }

  ///
  /// 로컬 데이터 불러오기
  ///
  Result<Map<String, String?>> getPdfMetaData() {
    try {
      return userRepository.getPdfMetaData();
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  ///
  /// Local State 초기화 메서드
  ///
  void resetLocalState() {
    debugPrint('로컬 데이터 초기화');
    state = const ResumeLocalState();
  }
}

///
/// 이력서 관리 페이지에서만 사용될 로컬 데이터 저장 형태 정의 클래스
///
class ResumeLocalState {
  final String localResumePath;
  final String localResumeTitle;
  final String localResumeDate;
  final String localPortfolioPath;
  final String localPortfolioTitle;
  final String localPortfolioDate;

  const ResumeLocalState({
    this.localResumePath = '',
    this.localResumeTitle = '',
    this.localResumeDate = '',
    this.localPortfolioPath = '',
    this.localPortfolioTitle = '',
    this.localPortfolioDate = '',
  });

  ResumeLocalState copyWith({
    String? localResumePath,
    String? localResumeTitle,
    String? localResumeDate,
    String? localPortfolioPath,
    String? localPortfolioTitle,
    String? localPortfolioDate,
  }) {
    return ResumeLocalState(
      localResumePath: localResumePath ?? this.localResumePath,
      localResumeTitle: localResumeTitle ?? this.localResumeTitle,
      localResumeDate: localResumeDate ?? this.localResumeDate,
      localPortfolioPath: localPortfolioPath ?? this.localPortfolioPath,
      localPortfolioTitle: localPortfolioTitle ?? this.localPortfolioTitle,
      localPortfolioDate: localPortfolioDate ?? this.localPortfolioDate,
    );
  }
}
