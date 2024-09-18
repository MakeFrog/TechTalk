import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/gradient_shine_effect_view.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/bubble_indicator.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_appear_view.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class BottomInputField extends HookConsumerWidget with ChatState, ChatEvent {
  const BottomInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColor.of.white,
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 240),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: chatAsyncAdapterValue(ref).when(
        data: (_) => _buildTextField(progressState(ref)),
        error: (_, __) => _buildTextField(InterviewProgress.error),
        loading: () => _buildTextField(InterviewProgress.initial),
      ),
    );
  }

  Widget _buildTextField(InterviewProgress progressState) {
    return HookBuilder(
      builder: (context) {
        final messageController = useTextEditingController();
        final showHighlightEffect = useState(isFirstInterview());

        final message = useListenableSelector(messageController, () {
          final input = messageController.text;
          if (showHighlightEffect.value.isTrue && input.isNotEmpty) {
            showHighlightEffect.value = false;
            updateFirstEnteredStateToTrue();
          }
          return input;
        });

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildMicButton(showHighlightEffect),
                if(showHighlightEffect.value)
                const Positioned(
                  top: -46,
                  child: AnimatedAppearView(
                    child: BubbleIndicator(
                      talePosition: BubbleTalePosition.left,
                      text: '음성으로 답변해 보세요!',
                    ),
                  ),
                ),
              ],
            ),
            const Gap(6),
            Expanded(
              child: IntrinsicWidth(
                child: Stack(
                  children: [
                    Positioned(
                      child: SizedBox(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          autofocus: AppSize.to.keyboardHeight == null,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            enabled: !progressState.isDoneOrError,
                            fillColor: AppColor.of.background1,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            contentPadding: const EdgeInsets.only(
                              right: 42,
                              left: 16,
                              top: 18,
                            ),
                            hintText: progressState.fieldHintText.tr(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Consumer(
                        builder: (context, ref, _) {
                          return IconButton(
                            icon: SvgPicture.asset(
                              /// NOTE : SVG 패키지 문제가 있어 colorFilter를 사용하지 않고 아이콘 자체를 반환
                              message.isNotEmpty && progressState.enableChat
                                  ? Assets.iconsSendActivate
                                  : Assets.iconsSend,
                            ),
                            onPressed: progressState.enableChat
                                ? () {
                                    onChatFieldSubmitted(
                                      ref,
                                      textEditingController: messageController,
                                    );
                                  }
                                : () {
                                    onChatFieldSubmittedOnWaitingState(
                                        progressState);
                                  },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMicButton(ValueNotifier<bool> showHighlightEffect) {
    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ShrinkGestureView(
            onTap: () {
              ref.read(isSpeechModeProvider.notifier).toggle();
            },
            borderRadius: BorderRadius.circular(22),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColor.of.blue1,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  if (showHighlightEffect.value.isTrue)
                    const GradientShineEffectView(),
                  Positioned(
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.iconsIconMic,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          showHighlightEffect.value
                              ? AppColor.of.white
                              : AppColor.of.brand3,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
