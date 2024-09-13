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

class BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  const BottomSpeechToTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SpeechToText 객체 생성
    final speechToText = useMemoized(stt.SpeechToText.new, []);
    final isListening = useState(false);
    final recognizedText = useState('');
    final showHighlightEffect = useState(isFirstInterview());

    ///
    /// SpeechToText 초기화 및 리스닝 상태 처리
    ///
    useEffect(() {
      Future<void> initSpeech() async {
        bool speechEnabled = await speechToText.initialize(
          onStatus: (status) {
            if (status == 'listening') {
              isListening.value = true;
            } else if (status == 'done') {
              isListening.value = false;
            }
            print('Speech status: $status');
          },
          onError: (error) {
            print(
              'Speech error: ${error.errorMsg}, permanent: ${error.permanent}',
            );

            // error_listen_failed 에러 처리
            if (error.errorMsg == 'error_listen_failed') {
              log('음성 인식에 실패했습니다. 에러 메시지: ${error.errorMsg}');
              // 사용자에게 음성 인식 실패 알림
              SnackBarService.showSnackBar(
                '음성 인식에 실패했습니다. 마이크 권한 또는 음성 인식 서비스 상태를 확인해주세요.',
              );
            }
          },
        );

        if (speechEnabled) {
          print('초기화됨');
        } else {
          print('사용 불가능');
        }
      }

      initSpeech();
      return null;
    });

    ///
    /// 음성 인식 시작
    /// 마이크, 음성 인식 권한 Handler
    ///
    Future<void> startListening() async {
      try {
        final hasMicPermission = await speechToText.hasPermission;
        final isSpeechAvailable = speechToText.isAvailable;

        print('마이크 권한 허용했는가? : $hasMicPermission');
        print('음성 인식 권한 허용했는가? $isSpeechAvailable');

        // 권한이 하나라도 허용되지 않은 경우 예외 처리
        if (!hasMicPermission || !isSpeechAvailable) {
          String missingPermissions = '';

          if (!hasMicPermission) {
            missingPermissions += '마이크 권한';
          }

          if (!isSpeechAvailable) {
            if (missingPermissions.isNotEmpty) {
              missingPermissions += ', ';
            }
            missingPermissions += '음성 인식 권한';
          }

          DialogService.show(
            dialog: AppDialog.dividedBtn(
              title: '권한 필요',
              subTitle: '$missingPermissions 설정이 필요합니다. 설정에서 권한을 허용해주세요.',
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

        // 음성 인식 시작
        await speechToText.listen(
          onResult: (result) {
            recognizedText.value = result.recognizedWords;
            print('Recognized words: ${recognizedText.value}');
          },
        );
      } catch (e) {
        log(e.toString());
        SnackBarService.showSnackBar('음성 인식을 시작할 수 없습니다. 다시 시도해주세요.');
      }
    }

    // 음성 인식을 중지하는 함수
    void stopListening() {
      speechToText.stop();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        children: [
          if (!isListening.value && recognizedText.value.isNotEmpty)
            _buildRecognizedText(recognizedText.value),
          // 음성 모드 입력 폼을 메소드에서 제거하고 직접 구현
          Container(
            margin: const EdgeInsets.symmetric(vertical: 36),
            height: 143,
            child: Stack(
              children: [
                // 음성 인식 버튼
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: isListening.value ? stopListening : startListening,
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
                              isListening.value
                                  ? Assets.iconsArrowLeft
                                  : Assets.iconsIconMic,
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

                // 타이핑 모드, 녹음 취소 버튼
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 타이핑 모드로 전환
                        GestureDetector(
                          onTap: () =>
                              ref.read(isSpeechModeProvider.notifier).toggle(),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColor.of.blue1,
                            child: SvgPicture.asset(
                              Assets.iconsTypingModeAa,
                              height: 16,
                            ),
                          ),
                        ),

                        // UI 레이아웃을 위한 Gap 설정
                        const Gap(48),

                        // 녹음 취소
                        GestureDetector(
                          onTap: () {
                            isListening.value
                                ? stopListening()
                                : print('녹음 취소 버튼이 현재 비활성화 되어있음');
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isListening.value
                                  ? AppColor.of.red1
                                  : AppColor.of.background1,
                            ),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.transparent,
                              child: SvgPicture.asset(
                                Assets.iconsDeleteOrWrong,
                                colorFilter: ColorFilter.mode(
                                  isListening.value
                                      ? AppColor.of.red2
                                      : AppColor.of.gray3,
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

                /// TYPING MODE INDUCTION TOOL TIP
                if (showHighlightEffect.value.isTrue)
                  Positioned(
                    left: 52,
                    top: 52,
                    child: AnimatedAppearView(
                      awaitAppearDuration: const Duration(milliseconds: 400),
                      child: SvgPicture.asset(
                        Assets.iconsTypingModeTooltip,
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
              style: TextStyle(
                fontSize: 16.0,
                color: AppColor.of.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
