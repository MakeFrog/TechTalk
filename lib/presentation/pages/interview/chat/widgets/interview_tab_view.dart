// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/bubble.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/gradient_shine_effect_view.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_appear_view.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';
import 'package:techtalk/presentation/widgets/common/indicator/exception_indicator.dart';

class InterviewTabView extends HookConsumerWidget with ChatState, ChatEvent {
  const InterviewTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSpeechMode = useState(false);

    useAutomaticKeepAlive();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Consumer(
              builder: (context, ref, _) {
                return chatAsyncAdapterValue(ref).when(
                  data: (_) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        controller: chatScrollController(ref),
                        shrinkWrap: true,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 24, bottom: 20) +
                            const EdgeInsets.symmetric(horizontal: 12),
                        separatorBuilder: (_, __) => const Gap(8),
                        itemCount: ref.watch(
                          chatMessageHistoryProvider
                              .select((value) => value.value?.length ?? 0),
                        ),
                        itemBuilder: (context, index) {
                          return Bubble(
                            chat: chatMessageHistory(ref)[index],
                            isLatestReceivedChatInEachSection: ref
                                .watch(chatMessageHistoryProvider.notifier)
                                .isLastReceivedChatInEachQuestion(
                                  index: index,
                                ),
                            interviewer: interviewer(ref),
                            onReportBtnTapped: () {
                              onReportBtnTapped(ref, index: index);
                            },
                          );
                        },
                      ),
                    );
                  },
                  error: (e, __) => const Center(
                    child: ExceptionIndicator(
                      subTitle: '다시 시도해주세요',
                      title: '채팅 내역을 불러오지 못했어요.',
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),

        ///
        /// 하단 입력창
        /// 두 개의 AnimatedSlide를 사용하여 각각의 위젯을 슬라이드 전환
        ///

        if (isSpeechMode.value)
          _BottomSpeechToTextField(isSpeechMode: isSpeechMode)
        else
          _BottomInputField(isSpeechMode: isSpeechMode),
      ],
    );
  }
}

class _BottomInputField extends HookConsumerWidget with ChatState, ChatEvent {
  final ValueNotifier<bool> isSpeechMode;

  const _BottomInputField({Key? key, required this.isSpeechMode})
      : super(key: key);

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
        data: (_) => _buildTextField(progressState(ref), isSpeechMode),
        error: (_, __) =>
            _buildTextField(InterviewProgress.error, isSpeechMode),
        loading: () => _buildTextField(InterviewProgress.initial, isSpeechMode),
      ),
    );
  }

  ///
  /// 입력폼
  ///
  Widget _buildTextField(
    InterviewProgress progressState,
    ValueNotifier<bool> isSpeechMode,
  ) {
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
                opacity: isFieldFocused || isSpeechMode.value ? 0 : 1,
                child: ShrinkGestureView(
                  onTap: () {
                    /// TODO
                    /// 윤수님 여기에 음성 인식 활성화 UI를 노출하는 로직을 연동해주시면됩니다!
                    /// onMicBtnTapped(isSpeechMode);
                    isSpeechMode.value = !isSpeechMode.value;
                    print('현재 SpeechMode인가? : ${isSpeechMode.value}');
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

class _BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  final ValueNotifier<bool> isSpeechMode;

  const _BottomSpeechToTextField({Key? key, required this.isSpeechMode})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SpeechToText 객체 생성
    final speechToText = useMemoized(stt.SpeechToText.new, []);
    final isListening = useState(false);
    final recognizedText = useState('');
    final showHighlightEffect = useState(isFirstInterview());

    // SpeechToText 초기화 및 리스닝 상태 처리
    useEffect(() {
      Future<void> initSpeech() async {
        bool available = await speechToText.initialize(
          onStatus: (status) => print('Speech status: $status'),
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
      isListening.value = true;
    }

    // 음성 인식을 중지하는 함수
    void stopListening() {
      speechToText.stop();
      isListening.value = false;
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
          _buildSpeechField(
            isSpeechMode,
            showHighlightEffect,
            isListening.value,
            recognizedText.value,
            startListening,
            stopListening,
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

  ///
  /// 음성 모드 입력 폼
  ///
  Widget _buildSpeechField(
    ValueNotifier<bool> isSpeechMode,
    ValueNotifier<bool> showHighlightEffect,
    bool isListening,
    String recognizedText,
    VoidCallback startListening,
    VoidCallback stopListening,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 36),
      height: 143,
      child: Stack(
        children: [
          // 음성 인식 버튼
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: isListening ? stopListening : startListening,
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
                        isListening
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
                    onTap: () {
                      isSpeechMode.value = !isSpeechMode.value;
                      print('현재 SpeechMode인가? : ${isSpeechMode.value}');
                    },
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
                      print('현재 SpeechMode인가? : ${isSpeechMode.value}');

                      isListening
                          ? stopListening()
                          : print('녹음 취소 버튼이 현재 비활성화 되어있음');
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: isListening
                          ? AppColor.of.red1
                          : AppColor.of.background1,
                      child: SvgPicture.asset(
                        Assets.iconsDeleteOrWrong,
                        colorFilter: ColorFilter.mode(
                          isListening ? AppColor.of.red2 : AppColor.of.gray3,
                          BlendMode.srcIn,
                        ),
                        // color: AppColor.of.gray3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// TYPING MODE INDUCTION TOOL TIP
          // if (showHighlightEffect.value.isTrue)
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
    );
  }
}
