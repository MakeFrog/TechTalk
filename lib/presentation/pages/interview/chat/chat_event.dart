import 'dart:async';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/speech_ui_state.enum.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_scroll_controller.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/bottom_speech_to_text_field.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

mixin class ChatEvent {
  /// 채팅 입력창이 전송 되었을 때
  ///
  /// - 유저 채팅 응답 추가
  /// - 유저 채팅 응답
  /// - 입력된 채팅 state 초기화
  /// - 스크롤 포지션 맨 아래로 변경
  ///
  Future<void> onChatFieldSubmitted(
    WidgetRef ref, {
    required TextEditingController textEditingController,
  }) async {
    unawaited(
      ref.read(chatScrollControllerProvider).animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
    );

    final message = textEditingController.text;
    if (message.isEmpty) {
      unawaited(HapticFeedback.vibrate());
      return SnackBarService.showSnackBar(
          ref.context.tr(LocaleKeys.interview_provideAnswer));
    }
    textEditingController.clear();

    await ref
        .read(chatMessageHistoryProvider.notifier)
        .proceedInterviewStep(message);
  }

  ///
  /// 채팅 전송이 불가능할 상태일 때 전송 버튼이 클릭 되었을 때
  ///
  void onChatFieldSubmittedOnWaitingState(InterviewProgress progressState) {
    unawaited(HapticFeedback.vibrate());
    late String message;

    final context = rootNavigatorKey.currentContext!;
    if (progressState.isDone) {
      message = context.tr(LocaleKeys.interview_interviewEnded);
    }

    if (progressState.isError) {
      message = context.tr(LocaleKeys.interview_errorHasDetected);
    }

    if (progressState.isInterviewerReplying) {
      message = context.tr(LocaleKeys.interview_waitForReply);
    }

    return SnackBarService.showSnackBar(message);
  }

  ///
  /// 앱바 뒤로 가기 버튼이 클릭 되었을 때
  ///
  void onAppbarBackBtnTapped(WidgetRef ref) {
    final room = ref.read(selectedChatRoomProvider);

    if (room.progressState.isOngoing) {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          title: rootNavigatorKey.currentContext!
              .tr(LocaleKeys.interview_notification),
          subTitle: rootNavigatorKey.currentContext!
              .tr(LocaleKeys.interview_confirmEndInterview),
          description: rootNavigatorKey.currentContext!
              .tr(LocaleKeys.interview_continueLater),
          showContentImg: false,
          leftBtnContent:
              rootNavigatorKey.currentContext!.tr(LocaleKeys.common_cancel),
          rightBtnContent:
              rootNavigatorKey.currentContext!.tr(LocaleKeys.common_confirm),
          onRightBtnClicked: () {
            ref.context.pop();
            ref.context.pop();
          },
          onLeftBtnClicked: () {
            ref.context.pop();
          },
        ),
      );
    } else {
      ref.context.pop();
    }
  }

  ///
  /// 리포트 버튼이 클릭 되었을 때
  ///
  Future<void> onReportBtnTapped(
    WidgetRef ref, {
    required int index,
  }) async {
    final chatMessages = ref.read(chatMessageHistoryProvider).requireValue;

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: tr(LocaleKeys.undefined_report),
        subTitle: tr(LocaleKeys.undefined_weirdResponse),
        description: tr(LocaleKeys.undefined_helpImproveAccuracy),
        leftBtnContent: tr(LocaleKeys.common_cancel),
        rightBtnContent: tr(LocaleKeys.common_confirm),
        showContentImg: false,
        onRightBtnClicked: () async {
          await reportChatUseCase(
            chatMessages[index] as FeedbackChatEntity,
            chatMessages[index + 1] as AnswerChatEntity,
          ).then((value) {
            value.fold(
              onSuccess: (value) {
                ref.context.pop();
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  SnackBar(
                    content: Text(tr(LocaleKeys.undefined_thankYouForFeedback)),
                  ),
                );
              },
              onFailure: (e) {
                ref.context.pop();
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  SnackBar(
                    content: Text(tr(LocaleKeys.undefined_thankYouForFeedback)),
                  ),
                );
              },
            );
          });
        },
        onLeftBtnClicked: () {
          ref.context.pop();
        },
      ),
    );
  }

  ///
  /// 면접 처음 입장한 유저의 경우
  /// 면접 처음 입장했다는 local Storage 값의 상태를 업데이트
  ///
  void updateFirstEnteredStateToTrue() {
    final response = userRepository.hasEnteredFirstInterview();
    response.fold(
      onSuccess: (hasEnteredFirstInterview) async {
        if (hasEnteredFirstInterview) return;
        await userRepository.changeFirstEnteredFieldToTrue();
        print('면접 최초 실행 여부 값 업데이트');
      },
      onFailure: (e) {
        log('CARD EVENT > $e');
        return Exception('로컬 스토리지 업데이트 실패');
      },
    );
  }

  ///
  /// 음성인식 초기화 관리
  ///
  Future<void> initSpeech(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) async {
    final isInitialized = await speechToText.initialize(
      onStatus: (state) {
        if (state == 'listening') {
          speechController.isListening.value = true;
        } else {
          speechController.isListening.value = false;
        }
      },
      onError: (error) {
        final errorMessage = getErrorMessage(error.errorMsg);
        if (errorMessage.isNotEmpty) {
          speechController.state.value = SpeechUiState.ready;
          log(errorMessage);
          SnackBarService.showSnackBar(errorMessage);
        }
      },
    );
    // 음성 인식이 초기화되었는지 확인
    if (isInitialized) {
      final isSpeechAvailable = speechToText.isAvailable;
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

  ///
  /// 에러 예외처리를 스낵바로 보여줌
  ///
  String getErrorMessage(String errorMsg) {
    switch (errorMsg) {
      case 'network':
        return '인터넷 연결에 문제가 있습니다. 네트워크 상태를 확인해주세요.';
      case 'not-allowed':
        return '마이크에 접근할 수 없습니다. 장치 상태를 확인해주세요.';
      case 'audio':
        return '오디오 장치에서 문제가 발생했습니다. 장치 상태를 확인해주세요.';
      case 'server':
        return '음성 인식 서버에 문제가 있습니다. 잠시 후 다시 시도해주세요.';
      case 'error_listen_failed':
        return '음성 인식에 실패했습니다. 다시 시도해주세요.';
      default:
        return '음성 인식 중 오류가 발생했습니다. 다시 시도해주세요.';
    }
  }

  ///
  /// 메인 버튼 클릭시 실행되는 함수
  ///
  Future<void> onMainBtnTapped(
    stt.SpeechToText speechToText,
    SpeechController speechController,
    WidgetRef ref,
    TextEditingController textEditingController,
  ) async {
    final hasPermission = await checkPermissions(speechToText);
    if (!hasPermission) return;

    switch (speechController.state.value) {
      case SpeechUiState.ready:
        await startRecognized(speechToText, speechController);
        break;
      case SpeechUiState.listening:
        stopRecognized(speechToText, speechController);
        break;
      case SpeechUiState.recognized:
        await submitRecognizedText(
          ref,
          textEditingController,
          speechToText,
          speechController,
        );
        break;
      case SpeechUiState.submitMessage:
        break;
    }
  }

  ///
  /// 권한 허용 함수
  ///
  Future<bool> checkPermissions(stt.SpeechToText speechToText) async {
    final hasMicPermission = await speechToText.hasPermission;
    final isSpeechAvailable = speechToText.isAvailable;

    if (!hasMicPermission || !isSpeechAvailable) {
      // 권한 부족시 처리 로직 (ex: 다이얼로그 표시)
      _showNeedMicPermissionsDialog();
      return false;
    }
    return true;
  }

  ///
  /// 마이크 권한허용 필요 다이어로그 노출
  ///
  void _showNeedMicPermissionsDialog() {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '권한 필요',
        subTitle: '설정에서 마이크 권한과 음성 인식 권한을 허용해주세요.',
        leftBtnContent: '취소',
        showContentImg: false,
        rightBtnContent: '설정하기',
        onRightBtnClicked: () async {
          rootNavigatorKey.currentContext?.pop();
          await AppSettings.openAppSettings();
        },
        onLeftBtnClicked: () {
          rootNavigatorKey.currentContext?.pop();
        },
      ),
    );
  }

  /// 음성 인식 활성화 '마이크' 버튼이 클릭 되었을 때
  ///
  /// - 음성 인식 가능 권한 여부를 요청 및 검사
  ///    - 만약 권한이 허용 안되었다면 권한 허용 팝업 노출
  /// - 권한 허용이 충족되었다면 음성 인식 활성화
  ///
  Future<void> onMicBtnTapped(WidgetRef ref) async {
    // 여러 권한을 한 번에 요청
    Map<Permission, PermissionStatus> statuses = await [
      Permission.speech,
      Permission.microphone,
    ].request();

    /// 두 권한 중 하나라도 허용되지 않은 경우
    /// 권한 허용 다이어로그 노출
    if (statuses.values.any((status) => !status.isGranted)) {
      _showNeedMicPermissionsDialog();
    } else {
      /// 키보드 focus 비활성화
      FocusScope.of(ref.context).unfocus();

      /// 약간의 딜레이를 주어 자연스럽게 음성 인식 활성화 ui 노출
      await Future.delayed(Duration(milliseconds: 120));
      ref.read(isSpeechModeProvider.notifier).toggle();
    }
  }

  ///
  /// 음성 인식 시작
  ///
  Future<void> startRecognized(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) async {
    // 음성 인식 시작 전에 텍스트 초기화
    speechController.recognizedText.value = '';

    // SpeechUiState 변경
    speechController.state.value = SpeechUiState.listening;

    await speechToText.listen(
      onResult: (result) {
        speechController.recognizedText.value = result.recognizedWords;
      },
    );
  }

  ///
  /// 음성 인식 정지
  ///
  void stopRecognized(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) {
    // 메인 버튼 비활성화
    if (speechController.recognizedText.value.isEmpty) {
      print('버튼 비활성화 : 인식된 텍스트 x');
    } else {
      speechToText.stop();
      speechController.state.value = SpeechUiState.recognized;
    }
  }

  ///
  /// 음성 인식 텍스트를 전송
  ///
  Future<void> submitRecognizedText(
    WidgetRef ref,
    TextEditingController textEditingController,
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) async {
    // 음성 인식된 텍스트 가져오기
    final recognizedText = speechController.recognizedText.value;

    // 텍스트 필드에 recognizedText를 설정
    textEditingController.text = recognizedText;

    // speechController 상태 변경하기
    speechController.state.value = SpeechUiState.submitMessage;

    // 기존 onChatFieldSubmitted 함수 사용하여 채팅 전송
    await onChatFieldSubmitted(
      ref,
      textEditingController: textEditingController,
    );

    // 예외처리 : 음성 전송중

    // 예외처리 : 전송 완료
    speechController.state.value = SpeechUiState.ready;
    speechController.recognizedText.value = '';
  }

  ///
  /// 녹음 취소 버튼 클릭시
  ///
  void cancleBtnClicked(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) {
    speechController.state.value = SpeechUiState.ready;
    speechController.recognizedText.value = '';

    // 녹음 중 리셋 버튼 클릭시
    if (speechController.isListening.value == true) {
      speechToText.stop();
    }
  }

  ///
  /// 타이핑 모드 버튼 클릭시
  ///
  void typingModeBtnClicked(
    WidgetRef ref,
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) {
    switch (speechController.state.value) {
      case SpeechUiState.listening:
        // 향후 텍스트 전달 기능 구현
        ref.read(isSpeechModeProvider.notifier).toggle();
        speechToText.stop();
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
  /// [AppSize] 모듈의 [keyboardHeight] 프러퍼티를
  /// 조건에 따라 초기화 시키는 로직
  ///
  Future<void> initializeKeyboardHeightOnCondition(BuildContext context) async {
    /// 캐싱된 키보드 높이 값이 없다면
    /// 높이를 가져올 수 있는 아래 로직을 실행
    if (AppSize.to.keyboardHeight == null ||
        (AppSize.to.keyboardHeight ?? 0) <= 150.0) {
      try {
        await EasyLoading.show(
          indicator: const EmptyBox(),
          maskType: EasyLoadingMaskType.custom,
        );

        /// 넉넉하게 delyaed를주어
        /// 키보드 auto focus가 되어 나타난 키보드 높이를 가져올 수 있도록 함
        await Future.delayed(const Duration(milliseconds: 500));
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        /// 획득한 키보드 높이를
        /// [AppSize] 모듈과 로컬 스터리지에 저장
        await AppSize.to.updateKeyboardHeight(keyboardHeight);
      } catch (e) {
        log(e.toString());
      } finally {
        await EasyLoading.dismiss();
      }
    }
  }
}
