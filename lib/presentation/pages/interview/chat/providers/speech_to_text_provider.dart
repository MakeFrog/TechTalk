import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'dart:isolate';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/helper/debouncer.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/constant/recrod_progress_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_progress_state_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/main_input_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';

///
/// Speech To Text 핵심 컨트롤러 Provider
/// 녹음 파일 생성 중단 상태 조작 및 음성 익신 텍스트 생성 로직과 관련된 로직을 고나리
///
class SpeechToTextProvider extends ChangeNotifier with ChatEvent {
  /// 음성 인식 상태 (준비, 듣는 중, 완료 , 등등)
  RecordProgressState progressState = RecordProgressState.initial;

  /// 애니메이션 활성화 모션에 사용되는 디바운서 (원형 백그라운드)
  final debouncer = Debouncer(const Duration(milliseconds: 600));

  /// 음성 녹음 컨트롤러
  final recordController = AudioRecorder();
  final speechController = SpeechToText();

  //// speech 컨트롤러 listen 가능 상태 여부
  Completer<void> isSpeechListenAvailable = Completer<void>();

  /// 음성 인식된 텍스트
  String recognizedText = '';

  /// SpeechToText로 인식된 텍스트
  String notifyText = '';

  /// 음성 녹음 파일이 저장되는 경로
  late String recordPath;

  ///
  /// 타이핑 모드 버튼 클릭시
  ///
  Future<void> onTypingModeBtnTapped(WidgetRef ref) async {
    if (progressState.isLoadingResult) {
      SnackBarService.showSnackBar(tr(LocaleKeys.interview_waitPlease));
      return;
    }

    if (await File(recordPath).exists()) {
      await File(recordPath).delete();
    }

    unawaited(recordController.cancel());

    if (progressState.isRecognized) {
      ref.read(mainInputControllerProvider).text = recognizedText;
    }

    ref.read(mainInputControllerProvider.notifier).focusNode.requestFocus();
    ref.read(isSpeechModeProvider.notifier).toggle();
  }

  ///
  /// 음성 인식 시작
  ///
  Future<void> startRecord(WidgetRef ref) async {
    final chatProgress = ref.read(interviewProgressStateProvider);
    if (chatProgress.isDone) {
      SnackBarService.showSnackBar(tr(LocaleKeys.interview_interviewEnded));
      ref.read(isSpeechModeProvider.notifier).toggle();
    }

    if (chatProgress.isInterviewerReplying) {
      SnackBarService.showSnackBar(tr(LocaleKeys.interview_waitForReply));
      return;
    }
    await Future.microtask(
        () => _updateProgressState(RecordProgressState.loading));

    notifyText = '';

    _updateProgressState(RecordProgressState.ready, resetText: true);
    await recordController.start(const RecordConfig(), path: recordPath);
    _updateProgressState(RecordProgressState.onProgress, resetText: true);
  }

  ///
  /// 음성 인식 정지
  ///
  Future<void> stopRecord(WidgetRef ref) async {
    _updateProgressState(RecordProgressState.loading);

    /// 녹음 중지
    await recordController.stop();

    await isSpeechListenAvailable.future;

    /// 입력된 텍스트가 없다면 알럿을 노출 후 초기화 상태로 변경
    if (notifyText.isEmpty) {
      SnackBarService.showSnackBar('입력된 음성이 없습니다');
      await File(recordPath).delete();
      _updateProgressState(RecordProgressState.initial);
      return;
    }

    /// 녹음된 텍스트 (Speech To Text)
    final recordedText = await recordToTextUseCase.call(recordPath);

    await recordedText.fold(onSuccess: (text) async {
      /// 기존 텍스트 입력폼에 저장되어 있던 텍스트와 녹음된 텍스트 병합
      final textFiledController = ref.read(mainInputControllerProvider);
      await File(recordPath).delete();

      recognizedText = textFiledController.text + text;
      if (recognizedText.trim().isEmpty) {
        SnackBarService.showSnackBar(tr(LocaleKeys.interview_recordFailed));
        _updateProgressState(RecordProgressState.initial);
      } else {
        _updateProgressState(RecordProgressState.recognized);
      }
    }, onFailure: (e) {
      _updateProgressState(RecordProgressState.initial);
      SnackBarService.showSnackBar(tr(LocaleKeys.interview_recordFailed));
      log('Speech To Text 실패');
    });
  }

  ///
  /// 진핸 상태 변경
  ///
  void _updateProgressState(RecordProgressState state,
      {bool resetText = false, bool allowNotify = true}) {
    progressState = state;
    if (resetText.isTrue) {
      recognizedText = '';
    }
    if (allowNotify.isTrue) {
      notifyListeners();
    }
  }

  ///
  /// 음성 인식 결과 제출
  ///
  Future<void> submitRecognizedText(WidgetRef ref) async {
    ref.read(mainInputControllerProvider).text = recognizedText;

    await onChatFieldSubmitted(ref);
    _updateProgressState(RecordProgressState.initial);
  }

  ///
  /// 녹음 모두 중단
  ///
  Future<void> cancelRecordMode(WidgetRef ref) async {
    if (progressState.isOnProgress ||
        progressState.isReady ||
        progressState.isRecognized) {
      if (progressState.isOnProgress || progressState.isReady) {
        _updateProgressState(RecordProgressState.loading);
        notifyListeners();
        unawaited(
            Future.wait([recordController.stop(), speechController.cancel()]));
      }

      _updateProgressState(RecordProgressState.initial, resetText: true);
    } else {
      if (progressState.isLoadingResult) {
        SnackBarService.showSnackBar(tr(LocaleKeys.interview_waitPlease));
      } else {
        ref.read(isSpeechModeProvider.notifier).toggle();
      }
    }
  }

  ///
  /// SpeechToText 컨트롤러 초기화
  ///
  Future<void> initializeSpeechController() async {
    final isEnabled = await speechController.initialize();
    if (isEnabled) {
      await speechController.listen(onResult: (result) {
        if (progressState.isOnProgress) {
          notifyText = result.recognizedWords;
          notifyListeners();
        }
      });

      isSpeechListenAvailable.complete(null);
    } else {
      unawaited(speechController.cancel());
    }
  }

  ///
  /// 각종 컨트롤러 및 path 초기 설정
  ///
  Future<void> initConfigSettings() async {
    final hasPermission = await recordController.hasPermission();
    if (!hasPermission) {
      showNeedMicPermissionsDialog();
      return;
    }

    Directory tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.path}/myFile.m4a';
    recordPath = targetPath;

    if (await File(recordPath).exists()) {
      await File(recordPath).delete();
    }

    await initializeSpeechController();
  }
}

final speechToTextProvider = AutoDisposeChangeNotifierProvider((ref) {
  final provider = SpeechToTextProvider();
  provider.initConfigSettings();

  ref.onDispose(() {
    provider.speechController.cancel();
    provider.recordController.dispose();
  });
  return provider;
});
