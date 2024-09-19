import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/chat/constant/recrod_progress_state.dart';
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
          alignment: Alignment.center,
          // color: Colors.red,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                alignment: Alignment.center,
                height: 141,
                constraints: const BoxConstraints(maxWidth: 280),
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
                                    RecordProgressState.submitMessage;
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
              _buildListeningIndicator(),
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

    return Positioned(
      left: 0,
      right: 0,
      top: -32,
      child: HookConsumer(
        builder: (context, ref, _) {
          final progressState =
              ref.watch(speechToTextProvider.select((c) => c.progressState));

          print('아지랑이둘 : ${progressState}');
          // ref.listen(speechToTextProvider.select((c) => c.progressState),
          //     (prev, now) {
          //   if (now.isOnProgress ||
          //       now.isErrorOccured && showIndicator.value.isFalse) {
          //     showIndicator.value = true;
          //     return;
          //   }
          //
          //   if (showIndicator.value.isTrue) {
          //     showIndicator.value = false;
          //   }
          // });

          return Center(
            child: AnimatedCrossFade(
              firstChild: Text(
                progressState.label ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle.body1.copyWith(color: textColor),
              ),
              secondChild: const EmptyBox(),
              crossFadeState:
                  progressState.isErrorOccured || progressState.isOnProgress
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          );

          return Text(
            'message',
            textAlign: TextAlign.center,
            style: AppTextStyle.body1.copyWith(color: textColor),
          );
        },
      ),
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
          crossFadeState: progressState == RecordProgressState.recognized
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
      case RecordProgressState.initial:
        print('UI State : $progressState');
        return Assets.iconsIconMic;
      case RecordProgressState.onProgress:
        print('UI State : $progressState');
        return Assets.iconsArrowLeft;
      case RecordProgressState.recognized:
        print('UI State : $progressState');
        return Assets.iconsSend;
      case RecordProgressState.submitMessage:
        print('UI State : $progressState');
        return Assets.iconsSend;
      case RecordProgressState.errorOccured:
        return '';
      // TODO: Handle this case.
      case RecordProgressState.ready:
        return Assets.iconsArrowLeft;
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
              color: progressSate == RecordProgressState.initial
                  ? AppColor.of.background1
                  : AppColor.of.red1,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                Assets.iconsDeleteOrWrong,
                colorFilter: ColorFilter.mode(
                  progressSate == RecordProgressState.initial
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
