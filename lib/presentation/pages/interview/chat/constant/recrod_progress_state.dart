import 'package:flutter/material.dart';
import 'package:techtalk/core/constants/assets.dart';

///
/// Speech to Text의 음성 인식 상태
///
enum RecordProgressState {
  initial(Colors.white, Assets.iconsIconMic), // 음성 인식을 시작할 준비가 된 상태
  ready(Color(0xFF3446EA), Assets.iconsArrowLeft), // 음성 인
  onProgress(Color(0xFF3446EA), Assets.iconsArrowLeft), // 음성 인식 중인 상태
  loading(Color(0xFF3446EA), Assets.iconsArrowLeft), // 음성 인식 중인 상태
  recognized(Colors.white, Assets.iconsSendUp), // 음성 인식 후 텍스트가 처리된 상태
  errorOccured(Colors.red, Assets.iconsSend); //  오류 발생

  final Color? color;
  final String iconPath;

  const RecordProgressState(this.color, this.iconPath);

  bool get isInitial => this == initial;

  bool get isReady => this == ready;

  bool get isOnProgress => this == onProgress;

  bool get isRecognized => this == recognized;

  bool get isErrorOccured => this == errorOccured;

  bool get isLoadingResult => this == loading;
}
