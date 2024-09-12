import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_mode_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/gradient_shine_effect_view.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_appear_view.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class BottomInputField extends HookConsumerWidget with ChatState, ChatEvent {
  const BottomInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColor.of.white,
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 240),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: chatAsyncAdapterValue(ref).when(
        data: (_) => _buildTextField(progressState(ref)),
        error: (_, __) => _buildTextField(InterviewProgress.error),
        loading: () => _buildTextField(InterviewProgress.initial),
      ),
    );
  }

  ///
  /// 입력폼
  ///
  Widget _buildTextField(InterviewProgress progressState) {
    return HookBuilder(
      builder: (context) {
        /// 하이라이트(마이크 기능 알림) 효과 노출 여부
        final showHighlightEffect = useState(isFirstInterview());
        final messageController = useTextEditingController();
        final focusNode = useFocusNode();

        const expandInOutDuration = Duration(milliseconds: 188);

        final message = useListenableSelector(
          messageController,
          () => messageController.text,
        );

        final isFieldFocused = useListenableSelector(focusNode, () {
          /// 최초 1번 입력폼이 활성화되면
          /// [showHighlightEffect] 마이크 강조 효과 해제
          if (showHighlightEffect.value.isTrue && focusNode.hasFocus) {
            showHighlightEffect.value = false;
          }

          return focusNode.hasFocus;
        });

        useEffect(
          () {
            updateFirstEnteredStateToTrue();
            return null;
          },
          [],
        );

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            AnimatedContainer(
              height: 48,
              alignment: Alignment.bottomRight,

              /// [NOTE] 74 == 44(mic icon) + 24(horizon padding) + 8(padding)
              width: AppSize.to.screenWidth - (isFieldFocused ? 30 : 74),
              duration: expandInOutDuration,
              child: TextField(
                controller: messageController,
                maxLines: null,
                focusNode: focusNode,
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

            /// MICROPHONE BUTTON
            AnimatedPositioned(
              left: isFieldFocused ? -50 : 0,
              duration: expandInOutDuration,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 120),
                opacity: isFieldFocused
                    // || isSpeechMode(ref
                    ? 0
                    : 1,
                child: Consumer(
                  builder: (context, ref, child) {
                    return ShrinkGestureView(
                      onTap: () {
                        ref.read(isSpeechModeProvider.notifier).toggle();
                      },
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        height: 44,
                        width: 44,
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
                    );
                  },
                ),
              ),
            ),

            /// MICROPHONE INDUCTION TOOL TIP
            if (showHighlightEffect.value.isTrue)
              Positioned(
                left: 0,
                top: -36,
                child: AnimatedAppearView(
                  awaitAppearDuration: const Duration(milliseconds: 800),
                  child: SvgPicture.asset(
                    Assets.iconsUseMicTooltip,
                  ),
                ),
              ),

            /// SEND BUTTON
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
                            onChatFieldSubmittedOnWaitingState(progressState);
                          },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
