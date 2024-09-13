// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_appear_view.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
import 'package:go_router/go_router.dart';

enum RecordingStatus { before, during, after }

class BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  const BottomSpeechToTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SpeechToText 객체 생성
    final speechToText = useMemoized(stt.SpeechToText.new, []);
    final isListening = useState(false);
    final recognizedText = useState('');
    final recordingStatus = useState(RecordingStatus.before);

    ///
    /// SpeechToText 초기화 및 리스닝 상태 처리
    ///
    useEffect(
      () {
        Future<void> initSpeech() async {
          bool speechEnabled = await speechToText.initialize(
            // status는 음성 인식이 활성화되고 나서 동작함
            onStatus: (status) {
              if (recordingStatus.value == RecordingStatus.during) {
                isListening.value = true;
              } else {
                isListening.value = false;
              }
            },

            // 에러 처리
            onError: (error) {
              String errorMessage = '';
              print('에러 메시지 : ${error.errorMsg}');

              if (error.errorMsg == 'network') {
                // 인터넷 연결 문제
                errorMessage = '인터넷 연결에 문제가 있습니다. 네트워크 상태를 확인해주세요.';
              } else if (error.errorMsg == 'not-allowed') {
                // 마이크 접근 불가 또는 다른 앱이 마이크 사용 중
                errorMessage = '마이크에 접근할 수 없습니다. 장치 상태를 확인해주세요.';
              } else if (error.errorMsg == 'audio') {
                // 오디오 장치 문제
                errorMessage = '오디오 장치에서 문제가 발생했습니다. 장치 상태를 확인해주세요.';
              } else if (error.errorMsg == 'server') {
                // 음성 인식 서버 문제
                errorMessage = '음성 인식 서버에 문제가 있습니다. 잠시 후 다시 시도해주세요.';
              } else if (error.errorMsg == 'error_listen_failed') {
                // 음성 인식 실패
                errorMessage = '음성 인식에 실패했습니다. 다시 시도해주세요.';
              } else {
                // 그 외 예외 상황
                errorMessage = '음성 인식 중 오류가 발생했습니다. 다시 시도해주세요.';
              }

              if (errorMessage.isNotEmpty) {
                log(errorMessage);
                SnackBarService.showSnackBar(errorMessage);
              }
            },
          );

          if (speechEnabled) {
            print('===== 음성 인식 사용 가능 =====');
          } else {
            print('===== 음성 인식 사용 불가능 =====');
            if (!await speechToText.hasPermission ||
                !speechToText.isAvailable) {
              print('마이크 권한 또는 음성 인식 권한이 필요합니다.');
            } else {
              print('알 수 없는 이유로 음성 인식이 불가능합니다.');
            }
          }
        }

        initSpeech();
        return null;
      },
      // 빈 배열을 의존성으로 추가하여 initSpeech()가 한 번만 실행되도록 설정
      [],
    );

    ///
    /// 음성 인식 시작
    ///
    Future<void> startListening() async {
      print('startListening 실행');
      recordingStatus.value = RecordingStatus.during;

      // 음성 인식 시작
      await speechToText.listen(
        onResult: (result) {
          recognizedText.value = result.recognizedWords;
        },
      );
    }

    // 음성 인식을 중지하는 함수
    void stopListening() {
      recordingStatus.value = RecordingStatus.after;
      speechToText.stop();
    }

    // 음성 인식을 중지하는 함수
    void resetRecognizedText() {
      recordingStatus.value = RecordingStatus.before;
      recognizedText.value = '';
      if (isListening.value == true) {
        stopListening();
      }
    }

    // 인식된 텍스트를 전송하는 함수
    Future<void> submitRecognizedText() async {
      // after 상태에서 호출되는 함수로, 음성 인식 후 텍스트를 처리하는 로직
      print('음성 인식이 완료되어 텍스트를 제출합니다.');
    }

    ///
    /// 메인 버튼 클릭시
    ///
    Future<void> onMainBtnClicked() async {
      try {
        final hasMicPermission = await speechToText.hasPermission;
        final isSpeechAvailable = speechToText.isAvailable;

        // 권한이 모두 허용돼있으면 바로 리스닝 시작
        if (await speechToText.hasPermission && speechToText.isAvailable) {
          print('권한 체크 완료');
          switch (recordingStatus.value) {
            case RecordingStatus.before:
              await startListening();
              break;
            case RecordingStatus.during:
              stopListening();
              break;
            case RecordingStatus.after:
              await submitRecognizedText();
              break;
          }
        }

        // 권한 허용 체크
        if (!hasMicPermission || !isSpeechAvailable) {
          DialogService.show(
            dialog: AppDialog.dividedBtn(
              title: '권한 필요',
              subTitle: '설정에서 마이크 권한과 음성 인식 권한을 허용해주세요.',
              leftBtnContent: '취소',
              showContentImg: false,
              rightBtnContent: '설정하기',
              onRightBtnClicked: () async {
                rootNavigatorKey.currentContext?.pop();
                await AppSettings.openAppSettings(
                  type: AppSettingsType.internalStorage,
                );
              },
              onLeftBtnClicked: () {
                rootNavigatorKey.currentContext?.pop();
              },
            ),
          );
          return;
        }
      } catch (e) {
        log(e.toString());
        SnackBarService.showSnackBar('음성 인식을 시작할 수 없습니다. 다시 시도해주세요.');
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                recognizedText.value.isEmpty &&
                        recordingStatus.value == RecordingStatus.during
                    ? '듣고 있어요'
                    : '',
                style: AppTextStyle.body1,
              ),
            ),
          ),
          if (recordingStatus.value == RecordingStatus.after)
            _buildRecognizedText(recognizedText.value),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 36),
            height: 143,
            child: Stack(
              children: [
                /// 메인 음성 버튼
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: onMainBtnClicked,
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.of.blue1,
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: SvgPicture.asset(
                              recordingStatus.value == RecordingStatus.before
                                  ? Assets.iconsIconMic
                                  : recordingStatus.value ==
                                          RecordingStatus.during
                                      ? Assets.iconsArrowLeft
                                      : Assets.iconsSend,
                              width: 44,
                              colorFilter: ColorFilter.mode(
                                AppColor.of.brand3,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// 타이핑 모드, 녹음 취소 버튼
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 타이핑 모드로 전환
                        GestureDetector(
                          onTap: () {
                            ref.read(isSpeechModeProvider.notifier).toggle();
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColor.of.blue1,
                            child: SvgPicture.asset(
                              Assets.iconsTypingModeAa,
                              height: 16,
                            ),
                          ),
                        ),

                        /// UI 레이아웃을 위한 Gap 설정
                        const Gap(48),

                        /// 녹음 취소
                        GestureDetector(
                          onTap: () {
                            recordingStatus.value == RecordingStatus.before
                                ? print('녹음 취소 버튼이 현재 비활성화 되어있음')
                                : resetRecognizedText();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: recordingStatus.value ==
                                      RecordingStatus.before
                                  ? AppColor.of.background1
                                  : AppColor.of.red1,
                            ),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.transparent,
                              child: SvgPicture.asset(
                                Assets.iconsDeleteOrWrong,
                                colorFilter: ColorFilter.mode(
                                  recordingStatus.value ==
                                          RecordingStatus.before
                                      ? AppColor.of.gray3
                                      : AppColor.of.red2,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// speech to text의 결과물을 보여줌
  ///
  Widget _buildRecognizedText(String recognizedText) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 12, left: 12),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColor.of.background1,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 100.0,
        ),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 4.0,
          radius: const Radius.circular(24.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 11.0),
            child: Text(
              recognizedText,
              style: AppTextStyle.body2,
            ),
          ),
        ),
      ),
    );
  }
}
