import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';

import 'package:techtalk/features/chat/repositories/enums/speech_ui_state.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/main_input_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';

class SpeechToTextProvider extends ChangeNotifier with ChatEvent {
  SpeechToText controller = SpeechToText();
  SpeechUiState progressState = SpeechUiState.ready; // 음성 인식 상태 (준비, 듣는 중, 완료)

  bool isListening = false;
  String recordedText = '';

  void changeListeningState({required bool targetState}) {
    isListening = targetState;
    notifyListeners();
  }

  void updateSpeechProgressState(SpeechUiState targetState) {
    progressState = targetState;
    notifyListeners();
  }

  bool get isSpeechTextEmpty => recordedText.isEmpty;

  bool get isListeningWithEmptyText =>
      progressState == SpeechUiState.listening && recordedText.isEmpty;

  ///
  /// 타이핑 모드 버튼 클릭시
  ///
  void onTypingModeBtnTapped(WidgetRef ref) {
    switch (progressState) {
      case SpeechUiState.listening:
        // 향후 텍스트 전달 기능 구현
        ref.read(isSpeechModeProvider.notifier).toggle();
        controller.stop();
        break;

      case SpeechUiState.recognized:
        // 향후 텍스트 전달 기능 구현
        ref.read(isSpeechModeProvider.notifier).toggle();
        break;

      default:
        ref.read(isSpeechModeProvider.notifier).toggle();
        break;
    }
  }

  ///
  /// 음성 인식 시작
  ///
  Future<void> startRecord(WidgetRef ref) async {
    final controller =
        ref.read(speechToTextProvider.select((c) => c.controller));

    /// 음성 인식 시작 전에 텍스트 초기화
    recordedText = '';

    /// SpeechUiState 변경
    ref
        .read(speechToTextProvider.notifier)
        .updateSpeechProgressState(SpeechUiState.listening);

    await controller.listen(
      onResult: (result) {
        recordedText = result.recognizedWords;
      },
    );
  }

  ///
  /// 음성 인식 정지
  ///
  void stopRecord(WidgetRef ref) {
    if (isSpeechTextEmpty) {
      print('버튼 비활성화 : 인식된 텍스트 x');
    } else {
      controller.stop();
      updateSpeechProgressState(SpeechUiState.recognized);
    }
  }

  ///
  /// 음성 인식 결과 제출
  ///
  Future<void> submitRecognizedText(WidgetRef ref) async {
    // 음성 인식된 텍스트 가져오기
    // final recognizedText = speechController.recognizedText.value;

    // 텍스트 필드에 recognizedText를 설정
    // textEditingController.text = recognizedText;

    // speechController 상태 변경하기
    updateSpeechProgressState(SpeechUiState.submitMessage);

    ref.read(mainInputControllerProvider.notifier).updateInput(recordedText);

    // 기존 onChatFieldSubmitted 함수 사용하여 채팅 전송
    await onChatFieldSubmitted(ref);

    // 예외처리 : 음성 전송중

    // 예외처리 : 전송 완료
    updateSpeechProgressState(SpeechUiState.ready);
    recordedText = '';

  }

  void cancelRecord(WidgetRef ref) {
    updateSpeechProgressState(SpeechUiState.ready);
    recordedText = '';

    // 녹음 중 리셋 버튼 클릭시
    if (isListening == true) {
      controller.stop();
    }
  }

  ///
  /// [SpeechToText] 컨트롤러 초기화
  ///
  Future<void> initializeSpeechController() async {
    final isInitialized = await controller.initialize(
      onStatus: (state) {
        changeListeningState(targetState: state == 'listening' ? true : false);
      },
      onError: (error) {
        final errorMessage = getErrorMessage(error.errorMsg);
        if (errorMessage.isNotEmpty) {
          updateSpeechProgressState(SpeechUiState.ready);
          log(errorMessage);
          SnackBarService.showSnackBar(errorMessage);
        }
      },
    );
    // 음성 인식이 초기화되었는지 확인
    if (isInitialized) {
      final isSpeechAvailable = controller.isAvailable;
      if (isSpeechAvailable) {
        print('음성 인식을 사용할 수 있습니다.');
      } else {
        print('음성 인식을 사용할 수 없습니다.');
      }
    } else {
      log('음성 인식 초기화에 실패했습니다.');
      SnackBarService.showSnackBar('음성 인식 초기화에 실패했습니다.');
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.cancel();
  }
}

final speechToTextProvider = AutoDisposeChangeNotifierProvider((ref) {
  final provider = SpeechToTextProvider();
  provider.initializeSpeechController();
  return provider;
});
