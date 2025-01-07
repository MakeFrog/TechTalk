import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resume_temp_data_info_provider.g.dart';

@Riverpod(keepAlive: true)
class ResumeTempDataInfo extends _$ResumeTempDataInfo {
  @override
  ResumeTempState build() => const ResumeTempState();

  /// 이력서 상태 업데이트
  void updateTempResume(String? path, String? title, String? date) {
    debugPrint('임시 이력서 업데이트');
    state = state.copyWith(
      tempResumePath: path,
      tempResumeTitle: title,
      tempResumeDate: date,
    );
  }

  /// 포트폴리오 상태 업데이트
  void updateTempPortfolio(String? path, String? title, String? date) {
    debugPrint('임시 포트폴리오 업데이트');
    state = state.copyWith(
      tempPortfolioPath: path,
      tempPortfolioTitle: title,
      tempPortfolioDate: date,
    );
  }

  /// Temp State 초기화 메서드
  void resetTempState() {
    debugPrint('임시 데이터 초기화');
    state = const ResumeTempState();
  }
}

///
/// [ResumeTempState]
/// - 이력서 관리 페이지에서만 사용될 임시 상태
///
/// [ResumeTempStateCopyWith]
/// - 클래스의 copywith에서 특정 값(not null)을 기본 값(null)으로 변경할 수 있도록 추상클래스 구현
///
class ResumeTempState {
  final String? tempResumePath;
  final String? tempResumeTitle;
  final String? tempResumeDate;
  final String? tempPortfolioPath;
  final String? tempPortfolioTitle;
  final String? tempPortfolioDate;
  final bool isTempChanged;

  const ResumeTempState({
    this.tempResumePath,
    this.tempResumeTitle,
    this.tempResumeDate,
    this.tempPortfolioPath,
    this.tempPortfolioTitle,
    this.tempPortfolioDate,
    this.isTempChanged = false,
  });

  ResumeTempStateCopyWith get copyWith => _ResumeTempStateCopyWith(this);
}

abstract class ResumeTempStateCopyWith {
  ResumeTempState call({
    String? tempResumePath,
    String? tempResumeTitle,
    String? tempResumeDate,
    String? tempPortfolioPath,
    String? tempPortfolioTitle,
    String? tempPortfolioDate,
    bool? isTempChanged,
  });
}

class _ResumeTempStateCopyWith implements ResumeTempStateCopyWith {
  final ResumeTempState value;
  static const Object _undefined = Object();

  const _ResumeTempStateCopyWith(this.value);

  @override
  ResumeTempState call({
    Object? tempResumePath = _undefined,
    Object? tempResumeTitle = _undefined,
    Object? tempResumeDate = _undefined,
    Object? tempPortfolioPath = _undefined,
    Object? tempPortfolioTitle = _undefined,
    Object? tempPortfolioDate = _undefined,
    Object? isTempChanged = _undefined,
  }) {
    return ResumeTempState(
      tempResumePath: tempResumePath == _undefined
          ? value.tempResumePath
          : tempResumePath as String?,
      tempResumeTitle: tempResumeTitle == _undefined
          ? value.tempResumeTitle
          : tempResumeTitle as String?,
      tempResumeDate: tempResumeDate == _undefined
          ? value.tempResumeDate
          : tempResumeDate as String?,
      tempPortfolioPath: tempPortfolioPath == _undefined
          ? value.tempPortfolioPath
          : tempPortfolioPath as String?,
      tempPortfolioTitle: tempPortfolioTitle == _undefined
          ? value.tempPortfolioTitle
          : tempPortfolioTitle as String?,
      tempPortfolioDate: tempPortfolioDate == _undefined
          ? value.tempPortfolioDate
          : tempPortfolioDate as String?,
      isTempChanged: isTempChanged == _undefined
          ? value.isTempChanged
          : isTempChanged as bool,
    );
  }
}
