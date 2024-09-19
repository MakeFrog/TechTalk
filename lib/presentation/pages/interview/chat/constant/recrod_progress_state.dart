import 'package:flutter/material.dart';
import 'package:techtalk/core/constants/assets.dart';

///
/// Speech to Text의 음성 인식 상태
///
enum RecordProgressState {
  initial(null, Colors.white, Assets.iconsIconMic), // 음성 인식을 시작할 준비가 된 상태
  ready('듣고 있어요', Color(0xFF3446EA), Assets.iconsArrowLeft), // 음성 인
  onProgress(null, Color(0xFF3446EA), Assets.iconsArrowLeft), // 음성 인식 중인 상태
  loadingResult(null, Color(0xFF3446EA), Assets.iconsArrowLeft), // 음성 인식 중인 상태
  recognized(null, Colors.white, Assets.iconsSendUp), // 음성 인식 후 텍스트가 처리된 상태
  submitMessage(null, Color(0xFF3446EA), Assets.iconsSend), // 메시지를 전송하고 있는 상태
  errorOccured('오류가 발생했어요', Colors.red, Assets.iconsSend); //  오류 발생

  final String? label;
  final Color? color;
  final String iconPath;

  const RecordProgressState(this.label, this.color, this.iconPath);

  bool get isInitial => this == initial;
  bool get isReady => this == ready;
  bool get isOnProgress => this == onProgress;
  bool get isRecognized => this == recognized;
  bool get isMessageSubmitted => this == submitMessage;
  bool get isErrorOccured => this == errorOccured;
  bool get isLoadingResult => this == loadingResult;
}
