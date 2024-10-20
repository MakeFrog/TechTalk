import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/gradient_shine_effect_view.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/bubble_indicator.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_appear_view.dart';

class BottomInputField extends HookConsumerWidget with ChatState, ChatEvent {
  const BottomInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: Container(
        color: AppColor.of.white,

        /// NOTE : 128 = 20(texHeight) * 4 + fieldHeight(48)
        constraints: const BoxConstraints(minHeight: 48, maxHeight: 128),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: HookBuilder(
          builder: (context) {
            final showHighlightEffect = useState(isFirstInterview());
            return chatAsyncAdapterValue(ref).when(
              data: (_) {
                return _buildTextField(
                  showHighlightEffect: showHighlightEffect,
                  progressState: interviewProgressState(ref),
                );
              },
              error: (_, __) => _buildTextField(
                showHighlightEffect: showHighlightEffect,
                progressState: InterviewProgress.error,
              ),
              loading: () => _buildTextField(
                showHighlightEffect: showHighlightEffect,
                progressState: InterviewProgress.initial,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required ValueNotifier<bool> showHighlightEffect,
    required InterviewProgress progressState,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildMicButton(showHighlightEffect),
            if (showHighlightEffect.value.isTrue)
              Positioned(
                top: -39,
                child: AnimatedAppearView(
                  child: Builder(
                    builder: (context) {
                      return BubbleIndicator(
                        talePosition: BubbleTalePosition.left,
                        text: tr(LocaleKeys.interview_answerVocally),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
        _buildTextInputForm(
            showHighlightEffect: showHighlightEffect,
            progressState: progressState),
      ],
    );
  }

  /// 텍스트 입력폼
  Widget _buildTextInputForm(
      {required ValueNotifier<bool> showHighlightEffect,
      required InterviewProgress progressState}) {
    return Expanded(
      child: IntrinsicWidth(
        child: HookConsumer(
          builder: (context, ref, _) {
            final message =
                useListenableSelector(listenedInputController(ref), () {
              final input = listenedInputController(ref).text;
              if (showHighlightEffect.value.isTrue && input.isNotEmpty) {
                showHighlightEffect.value = false;
              }
              return input;
            });

            return Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    child: TextField(
                      style: AppTextStyle.body2,
                      controller: unListenedInputController(ref),
                      maxLines: null,
                      focusNode: focusNode(ref),
                      enabled: progressState.canEnableTextField,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        enabled: !progressState.isDoneOrError,
                        fillColor: AppColor.of.background1,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        contentPadding: const EdgeInsets.only(
                            right: 42, left: 16, top: 14, bottom: 14),
                        hintStyle: AppTextStyle.body2
                            .copyWith(color: AppColor.of.gray3),
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
                          message.isNotEmpty && progressState.enableChat
                              ? Assets.iconsRoundedSend
                              : Assets.iconsRoundedSendInactive,
                          height: 32,
                          width: 32,
                          // NOTE : SVG 패키지 문제가 있어 colorFilter를 사용하지 않고 아이콘 자체를 반환
                        ),
                        onPressed: progressState.enableChat
                            ? () {
                                onChatFieldSubmitted(ref);
                              }
                            : () {
                                onChatFieldSubmittedOnWaitingState(
                                  progressState,
                                );
                              },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 음성인식 마이크 활성화 버튼
  Widget _buildMicButton(ValueNotifier<bool> showHighlightEffect) {
    return Consumer(
      builder: (context, ref, _) {
        return BounceTapper(
          highlightColor: Colors.transparent,
          delayedDurationBeforeGrow: Duration.zero,
          onTap: () {
            onMicBtnTapped(ref);
          },
          child: Container(
            color: Colors.transparent,

            /// 넉넉하게 터치 영역을 패딩으로 줌
            padding: const EdgeInsets.fromLTRB(0, 8, 6, 8),
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
                        Assets.iconsTextFieldMic,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          showHighlightEffect.value
                              ? AppColor.of.white
                              : AppColor.of.blue2,
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
