import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_appear_view.dart';

class BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  const BottomSpeechToTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SpeechToText 객체 생성
    final speechToText = stt.SpeechToText();
    final isListening = useState(false);
    final recognizedText = useState('');
    final showHighlightEffect = useState(isFirstInterview());

    // SpeechToText 초기화 및 리스닝 상태 처리
    useEffect(() {
      Future<void> initSpeech() async {
        bool available = await speechToText.initialize(
          onStatus: (status) {
            if (status == 'listening') {
              isListening.value = true;
            }
            if (status == 'done') {
              isListening.value = false;
            }
            print('Speech status: $status');
          },
          onError: (error) => print('Speech error: $error'),
        );

        if (available) {
          print('초기화됨');
        } else {
          print('사용 불가능');
        }
      }

      initSpeech();
      return null;
    });

    // 음성 인식을 시작하는 함수
    void startListening() {
      speechToText.listen(
        onResult: (result) {
          recognizedText.value = result.recognizedWords;
          print('Recognized words: ${recognizedText.value}');
        },
      );
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
          maxHeight: 100.0, // 4줄에 해당하는 최대 높이를 설정 (줄바꿈에 따라 조정 가능)
        ),
        child: SingleChildScrollView(
          child: Text(
            recognizedText,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColor.of.black,
            ),
          ),
        ),
      ),
    );
  }
}
