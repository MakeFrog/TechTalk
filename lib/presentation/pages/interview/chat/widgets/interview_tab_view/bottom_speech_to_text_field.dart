import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/enums/speech_ui_state.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';

/// Speech to Text 상태 객체
class SpeechController {
  final ValueNotifier<SpeechUiState> state; // 음성 인식 상태 (준비, 듣는 중, 완료)
  final ValueNotifier<String> recognizedText; // 음성 인식된 텍스트
  final ValueNotifier<bool> isListening; // 음성 인식 활성화 여부

  SpeechController({
    required this.state,
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
      state: useState(SpeechUiState.ready),
      recognizedText: useState(''),
      isListening: useState(false),
    );

    /// 음성 인식 초기화
    useEffect(
      () {
        initSpeech(speechToText, speechController);
        return null;
      },
    );

    return Container(
      constraints: BoxConstraints(
        minHeight: AppSize.to.keyboardHeight != null
            ? AppSize.to.keyboardHeight! - AppSize.to.bottomInset
            : AppSize.to.screenHeight * 0.4,
      ),
      // color: Colors.red,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 음성 인식 중일 때 보여줄 텍스트
          Positioned(child: _buildListeningIndicator(speechController)),

          // 음성 인식된 텍스트의 결과물을 보여줌
          if (speechController.state.value == SpeechUiState.recognized)
            _buildRecognizedText(speechController),

          // 버튼 UI
          Container(
            alignment: Alignment.center,
            height: 141,
            constraints: const BoxConstraints(maxWidth: 281),
            margin: const EdgeInsets.symmetric(
              horizontal: 48,
            ),
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
                          backgroundColor: speechController.state.value ==
                                  SpeechUiState.submitMessage
                              ? AppColor.of.brand3
                              : Colors.white,
                          child: Center(
                            child: SvgPicture.asset(
                              _getMainBtnIcon(speechController.state.value),
                              width: 44,
                              colorFilter: speechController.state.value ==
                                      SpeechUiState.submitMessage
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTypingModeBtn(speechToText, speechController),
                      _buildCancelBtn(speechToText, speechController),
                    ],
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

    if (speechController.state.value == SpeechUiState.listening &&
        speechController.recognizedText.value.isEmpty) {
      message = '듣고 있어요';
      textColor = AppColor.of.black;
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
    // ScrollController를 명시적으로 설정
    final ScrollController scrollController = ScrollController();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.of.background1,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 80),
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          thickness: 4,
          radius: const Radius.circular(24),
          child: SingleChildScrollView(
            controller: scrollController,
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
  String _getMainBtnIcon(SpeechUiState status) {
    switch (status) {
      case SpeechUiState.ready:
        print('UI State : $status');
        return Assets.iconsIconMic;
      case SpeechUiState.listening:
        print('UI State : $status');
        return Assets.iconsArrowLeft;
      case SpeechUiState.recognized:
        print('UI State : $status');
        return Assets.iconsSend;
      case SpeechUiState.submitMessage:
        print('UI State : $status');
        return Assets.iconsSend;
    }
  }

  // 타이핑 모드 전환 버튼
  Widget _buildTypingModeBtn(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () =>
              typingModeBtnClicked(ref, speechToText, speechController),
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
  Widget _buildCancelBtn(
    stt.SpeechToText speechToText,
    SpeechController speechController,
  ) {
    return Consumer(
      builder: (context, ref, _) {
        return GestureDetector(
          onTap: () {
            if (speechController.state.value == SpeechUiState.ready) {
              ref.read(isSpeechModeProvider.notifier).toggle();
            } else {
              cancleBtnClicked(speechToText, speechController);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: speechController.state.value == SpeechUiState.ready
                  ? AppColor.of.background1
                  : AppColor.of.red1,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                Assets.iconsDeleteOrWrong,
                colorFilter: ColorFilter.mode(
                  speechController.state.value == SpeechUiState.ready
                      ? AppColor.of.gray3
                      : AppColor.of.red2,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
