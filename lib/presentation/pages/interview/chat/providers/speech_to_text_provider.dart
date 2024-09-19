import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';

import 'package:techtalk/presentation/pages/interview/chat/constant/recrod_progress_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/main_input_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';

class SpeechToTextProvider extends ChangeNotifier with ChatEvent {
  SpeechToText controller = SpeechToText();
  RecordProgressState progressState =
      RecordProgressState.initial; // 음성 인식 상태 (준비, 듣는 중, 완료)

  bool isListening = false;
  String recordedText = '';

  void changeListeningState({required bool targetState}) {
    isListening = targetState;
    notifyListeners();
  }

  void updateSpeechProgressState(RecordProgressState targetState) {
    progressState = targetState;
    notifyListeners();
  }

  bool get isSpeechTextEmpty => recordedText.isEmpty;

  ///
  /// 타이핑 모드 버튼 클릭시
  ///
  void onTypingModeBtnTapped(WidgetRef ref) async {
    try {
      if (progressState.isLoadingResult) {
        SnackBarService.showSnackBar('음성인식 결과를 로드하고 있습니다');
        return;
      }

      if (progressState.isRecognized) {
        ref.read(mainInputControllerProvider).text = recordedText;
      }

      await controller.cancel();

      ref.read(mainInputControllerProvider.notifier).focusNode.requestFocus();
      ref.read(isSpeechModeProvider.notifier).toggle();
    } catch (e) {
      print(e);
    }
  }

  ///
  /// 음성 인식 시작
  ///
  Future<void> startRecord(WidgetRef ref) async {
    /// 음성 인식 시작 전에 텍스트 초기화
    recordedText = '';

    updateSpeechProgressState(RecordProgressState.ready);

    await controller.listen(
      onResult: (result) {
        if (progressState.isReady) {
          updateSpeechProgressState(RecordProgressState.onProgress);
        }

        if (progressState.isOnProgress) {
          recordedText = result.recognizedWords;
          notifyListeners();
        }
      },
    );
  }

  ///
  /// 음성 인식 정지
  ///
  Future<void> stopRecord(WidgetRef ref) async {
    if (isSpeechTextEmpty) {
      SnackBarService.showSnackBar('인식된 답변이 없습니다');
    } else {
      updateSpeechProgressState(RecordProgressState.loadingResult);
      await EasyLoading.show(
        indicator: const EmptyBox(),
        maskType: EasyLoadingMaskType.custom,
      );

      /// 성격을 급한 유저를 배려하여
      /// 음성 인식 마무리할 수 있는 딜리에 설정
      await Future.delayed(const Duration(milliseconds: 300));
      await controller.stop();

      final textFiledController = ref.read(mainInputControllerProvider);

      recordedText = textFiledController.text + recordedText;

      // await controller.cancel();
      await EasyLoading.dismiss();
      updateSpeechProgressState(RecordProgressState.recognized);
    }
  }

  /// 음성 인식 결과 제출
  ///
  Future<void> submitRecognizedText(WidgetRef ref) async {
    // 음성 인식된 텍스트 가져오기
    // final recognizedText = speechController.recognizedText.value;

    // 텍스트 필드에 recognizedText를 설정
    // textEditingController.text = recognizedText;

    ref.read(mainInputControllerProvider).text = recordedText;

    print('찌방이');
    // 기존 onChatFieldSubmitted 함수 사용하여 채팅 전송
    await onChatFieldSubmitted(ref);

    // speechController 상태 변경하기
    updateSpeechProgressState(RecordProgressState.initial);

    // 예외처리 : 음성 전송중

    // 예외처리 : 전송 완료
    // updateSpeechProgressState(RecordProgressState.initial);
  }

  Future<void> cancelRecordMode(WidgetRef ref) async {
    if (progressState.isOnProgress ||
        progressState.isReady ||
        progressState.isRecognized) {
      await controller.stop();
      updateSpeechProgressState(RecordProgressState.initial);
      recordedText = '';
    } else {
      ref.read(isSpeechModeProvider.notifier).toggle();
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
          updateSpeechProgressState(RecordProgressState.initial);
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
