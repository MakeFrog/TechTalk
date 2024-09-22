import 'package:bounce_tapper/bounce_tapper.dart';
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
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_to_text_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/rounded_mic_motion_view.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';


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
          constraints: BoxConstraints(
            minHeight: AppSize.ratioHeight(280.0),
          ),
          alignment: Alignment.center,
          // color: Colors.red,
          width: double.infinity,
          child: Container(
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
                  child: BounceTapper(
                    highlightBorderRadius: BorderRadius.circular(106),
                    onTap: () => onRecordMainBtnTapped(
                      ref,
                    ),
                    child: const RoundedMicMotionView(),
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
        ),
      ],
    );
  }

  // 음성 인식된 텍스트의 결과물을 보여줌
  Widget _buildRecognizedText() {
    return HookConsumer(
      builder: (context, ref, _) {
        final recognizedText =
            ref.read(speechToTextProvider.select((c) => c.recognizedText));
        final progressState =
            ref.read(speechToTextProvider.select((c) => c.progressState));

        final scrollController = useScrollController();

        return AnimatedSizeAndFade.showHide(
          show: progressState == RecordProgressState.recognized,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              color: AppColor.of.background1,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 80),
              child: Scrollbar(
                controller: scrollController,
                interactive: true,
                thumbVisibility: true,
                thickness: 4,
                radius: const Radius.circular(24),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.only(right: 11),
                  child: Text(
                    recognizedText,
                    style: AppTextStyle.body2,
                  ),
                ),
              ),
            ),
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

        return Assets.iconsSend;
      case RecordProgressState.errorOccured:
        return '';
      // TODO: Handle this case.
      case RecordProgressState.ready:
        return Assets.iconsArrowLeft;
      case RecordProgressState.loading:
        return Assets.iconsArrowLeft;
    }
  }

  // 타이핑 모드 전환 버튼
  Widget _buildTypingModeBtn(
    WidgetRef ref,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        return BounceTapper(
          highlightBorderRadius: BorderRadius.circular(24),
          onTap: () {
            ref.read(speechToTextProvider.notifier).onTypingModeBtnTapped(ref);
          },
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
        return BounceTapper(
          highlightBorderRadius: BorderRadius.circular(24),
          onTap: () {
            onRecordCancelBtnTapped(ref);
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
