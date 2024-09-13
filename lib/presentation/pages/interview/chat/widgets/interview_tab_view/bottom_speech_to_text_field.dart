import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/enums/speech_state.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';

/// Speech to Text 상태 객체
class SpeechController {
  final ValueNotifier<SpeechState> status; // 음성 인식 상태 (준비, 듣는 중, 완료)
  final ValueNotifier<String> recognizedText; // 음성 인식된 텍스트
  final ValueNotifier<bool> isListening; // 음성 인식 활성화 여부

  SpeechController({
    required this.status,
    required this.recognizedText,
    required this.isListening,
  });
}

class BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  const BottomSpeechToTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController = TextEditingController();
    final speechToText = useMemoized(stt.SpeechToText.new, []);
    final speechController = SpeechController(
      status: useState(SpeechState.ready),
      recognizedText: useState(''),
      isListening: useState(false),
    );

    /// 음성 인식 초기화
    useEffect(() {
      initSpeech(speechToText, speechController);
      return null;
    }, []);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          // 음성 인식 중일 때 보여줄 텍스트
          _buildListeningIndicator(speechController),

          // 음성 인식된 텍스트의 결과물을 보여줌
          if (speechController.status.value == SpeechState.recognized)
            _buildRecognizedText(speechController),

          // 버튼 UI
          Container(
            margin: const EdgeInsets.symmetric(vertical: 36),
            height: 143,
            child: Stack(
              children: [
                // 메인 버튼
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () => onMainBtnTapped(
                      speechToText,
                      speechController,
                      ref,
                      textEditingController,
                    ),
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
                          backgroundColor: speechController.status.value ==
                                  SpeechState.submitMessage
                              ? AppColor.of.brand3
                              : Colors.white,
                          child: Center(
                            child: SvgPicture.asset(
                              _getMainButtonIcon(speechController.status.value),
                              width: 44,
                              colorFilter: speechController.status.value ==
                                      SpeechState.submitMessage
                                  ? const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    )
                                  : ColorFilter.mode(
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

                // 하단 버튼
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTypingModeButton(),
                        const Gap(48),
                        _buildCancelButton(speechToText, speechController),
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

  // 음성 인식 중일 때 보여줄 텍스트
  Widget _buildListeningIndicator(SpeechController speechController) {
    String message = '';
    Color textColor = AppColor.of.black;

    // UI만 Listening 모드로 변경됨
    if (speechController.status.value == SpeechState.listening) {
      // 인식된 텍스트가 없을 때
      if (speechController.recognizedText.value.isEmpty) {
        // SpeechToText에서 Listening 상태 진입 중일때
        if (speechController.isListening.value == false) {
          message = '잠시만 기다려주세요';
          textColor = AppColor.of.red2;
        }
        // SpeechToText에서 Listening 상태 진입 성공시
        else {
          message = '듣고 있어요';
          textColor = AppColor.of.black;
        }
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          message,
          style: AppTextStyle.body1.copyWith(color: textColor),
        ),
      ),
    );
  }

  // 음성 인식된 텍스트의 결과물을 보여줌
  Widget _buildRecognizedText(SpeechController speechController) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.of.background1,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 4,
          radius: const Radius.circular(24),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 11),
            child: Text(
              speechController.recognizedText.value,
              style: AppTextStyle.body2,
            ),
          ),
        ),
      ),
    );
  }

  // 녹음 상태에 따라 메인 버튼 아이콘 변경
  String _getMainButtonIcon(SpeechState status) {
    switch (status) {
      case SpeechState.ready:
        print('SpeechState : $status');
        return Assets.iconsIconMic;
      case SpeechState.listening:
        print('SpeechState : $status');
        return Assets.iconsArrowLeft;
      case SpeechState.recognized:
        print('SpeechState : $status');
        return Assets.iconsSend;
      case SpeechState.submitMessage:
        print('SpeechState : $status');
        return Assets.iconsSend;
    }
  }

  // 타이핑 모드 전환 버튼
  Widget _buildTypingModeButton() {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () => ref.read(isSpeechModeProvider.notifier).toggle(),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColor.of.blue1,
            child: SvgPicture.asset(Assets.iconsTypingModeAa, height: 16),
          ),
        );
      },
    );
  }

  // 녹음 취소 버튼
  Widget _buildCancelButton(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) {
    return GestureDetector(
      onTap: () {
        if (speechController.status.value == SpeechState.ready) {
          print('현재 비활성화 되어있음');
        } else {
          resetRecognizedText(speechToText, speechController);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: speechController.status.value == SpeechState.ready
              ? AppColor.of.background1
              : AppColor.of.red1,
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            Assets.iconsDeleteOrWrong,
            colorFilter: ColorFilter.mode(
              speechController.status.value == SpeechState.ready
                  ? AppColor.of.gray3
                  : AppColor.of.red2,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}