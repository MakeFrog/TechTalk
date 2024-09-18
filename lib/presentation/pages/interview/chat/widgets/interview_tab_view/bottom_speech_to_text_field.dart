import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/enums/speech_ui_state.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_to_text_provider.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';

class BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  const BottomSpeechToTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(speechToTextProvider);

    return Column(
      children: [
        // 음성 인식된 텍스트의 결과물을 보여줌
        _buildRecognizedText(),

        Container(
          color: Colors.red,
          constraints: BoxConstraints(
            minHeight: AppSize.to.keyboardHeight != null
                ? AppSize.to.keyboardHeight! - AppSize.to.bottomInset
                : 280.0,
          ),
          // color: Colors.red,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 음성 인식 중일 때 보여줄 텍스트
              _buildListeningIndicator(),

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
                          ref,
                        ),
                        child: Container(
                          width: 112,
                          height: 112,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.of.blue1,
                          ),
                          child: Center(
                            child: Consumer(
                              builder: (context, ref, _) {
                                final isProgressOnSubmit = ref.watch(
                                        speechToTextProvider
                                            .select((c) => c.progressState)) ==
                                    SpeechUiState.submitMessage;
                                return CircleAvatar(
                                  radius: 44,
                                  backgroundColor: isProgressOnSubmit
                                      ? AppColor.of.brand3
                                      : Colors.white,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      _getMainBtnIcon(ref),
                                      width: 44,
                                      colorFilter: isProgressOnSubmit
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
                                );
                              },
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
                          _buildTypingModeBtn(ref),
                          _buildCancelBtn(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 음성 인식 중일 때 보여줄 텍스트
  Widget _buildListeningIndicator() {
    String message = '';
    Color textColor = AppColor.of.black;

    return Consumer(
      builder: (context, ref, _) {
        final isReady = ref.watch(
            speechToTextProvider.select((c) => c.isListeningWithEmptyText));

        if (isReady) {
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
      },
    );
  }

  // 음성 인식된 텍스트의 결과물을 보여줌
  Widget _buildRecognizedText() {
    return HookConsumer(
      builder: (context, ref, _) {
        final recognizedText =
            ref.read(speechToTextProvider.select((c) => c.recordedText));
        final progressState =
            ref.read(speechToTextProvider.select((c) => c.progressState));

        return AnimatedCrossFade(
          firstChild: EmptyBox(),
          secondChild: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColor.of.background1,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 80),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 4,
                radius: const Radius.circular(24),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 11),
                  child: Text(
                    recognizedText,
                    style: AppTextStyle.body2,
                  ),
                ),
              ),
            ),
          ),
          crossFadeState: progressState == SpeechUiState.recognized
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(
            milliseconds: 220,
          ),
        );
      },
    );
  }

  // 녹음 상태에 따라 메인 버튼 아이콘 변경
  String _getMainBtnIcon(WidgetRef ref) {
    final progressState =
        ref.read(speechToTextProvider.select((c) => c.progressState));
    switch (progressState) {
      case SpeechUiState.ready:
        print('UI State : $progressState');
        return Assets.iconsIconMic;
      case SpeechUiState.listening:
        print('UI State : $progressState');
        return Assets.iconsArrowLeft;
      case SpeechUiState.recognized:
        print('UI State : $progressState');
        return Assets.iconsSend;
      case SpeechUiState.submitMessage:
        print('UI State : $progressState');
        return Assets.iconsSend;
    }
  }

  // 타이핑 모드 전환 버튼
  Widget _buildTypingModeBtn(
    WidgetRef ref,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () => ref
              .read(speechToTextProvider.notifier)
              .onTypingModeBtnTapped(ref),
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
  Widget _buildCancelBtn() {
    return Consumer(
      builder: (context, ref, _) {
        final progressSate =
            ref.read(speechToTextProvider.select((c) => c.progressState));
        return GestureDetector(
          onTap: () {
            ref.read(isSpeechModeProvider.notifier).toggle();
            // if (speechController.progressState.value == SpeechUiState.ready) {
            //   ref.read(isSpeechModeProvider.notifier).toggle();
            // } else {
            //   onCancelRecordBtnTapped(speechToText, speechController);
            // }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: progressSate == SpeechUiState.ready
                  ? AppColor.of.background1
                  : AppColor.of.red1,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                Assets.iconsDeleteOrWrong,
                colorFilter: ColorFilter.mode(
                  progressSate == SpeechUiState.ready
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
