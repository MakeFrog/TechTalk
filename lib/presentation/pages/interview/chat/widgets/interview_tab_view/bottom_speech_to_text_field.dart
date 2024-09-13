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

enum RecordingStatus { before, during, after }

class BottomSpeechToTextField extends HookConsumerWidget
    with ChatState, ChatEvent {
  const BottomSpeechToTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speechToText = useMemoized(stt.SpeechToText.new, []);
    final isListening = useState(false);
    final recognizedText = useState('');
    final recordingStatus = useState(RecordingStatus.before);

    /// SpeechToText 초기화 및 리스닝 상태 처리
    useEffect(() {
      initSpeech(speechToText, recordingStatus, isListening);
      return null;
    }, []);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          /// 음성 인식 중일 때 보여줄 텍스트
          _buildListeningIndicator(recordingStatus, recognizedText),

          /// 음성 인식된 텍스트의 결과물을 보여줌
          if (recordingStatus.value == RecordingStatus.after)
            _buildRecognizedText(recognizedText.value),

          /// 메인 및 하단 버튼 UI
          _buildSpeechModeButtons(
            speechToText,
            recordingStatus,
            recognizedText,
            isListening,
          ),
        ],
      ),
    );
  }

  /// 음성 인식 중일 때 보여줄 텍스트
  Widget _buildListeningIndicator(
    ValueNotifier<RecordingStatus> recordingStatus,
    ValueNotifier<String> recognizedText,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          recognizedText.value.isEmpty &&
                  recordingStatus.value == RecordingStatus.during
              ? '듣고 있어요'
              : '',
          style: AppTextStyle.body1,
        ),
      ),
    );
  }

  /// 음성 인식된 텍스트의 결과물을 보여줌
  Widget _buildRecognizedText(String recognizedText) {
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
            child: Text(recognizedText, style: AppTextStyle.body2),
          ),
        ),
      ),
    );
  }

  /// 메인 및 하단 버튼 UI
  Widget _buildSpeechModeButtons(
    stt.SpeechToText speechToText,
    ValueNotifier<RecordingStatus> recordingStatus,
    ValueNotifier<String> recognizedText,
    ValueNotifier<bool> isListening,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 36),
      height: 143,
      child: Stack(
        children: [
          _buildMainButton(speechToText, recordingStatus, recognizedText),
          _buildBottomButtons(
              speechToText, recordingStatus, recognizedText, isListening),
        ],
      ),
    );
  }

  /// 메인 버튼 (음성 인식 시작/중지)
  Widget _buildMainButton(
    stt.SpeechToText speechToText,
    ValueNotifier<RecordingStatus> recordingStatus,
    ValueNotifier<String> recognizedText,
  ) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () => onMainBtnTapped(
          speechToText,
          recordingStatus,
          recognizedText,
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
              backgroundColor: Colors.white,
              child: Center(
                child: SvgPicture.asset(
                  _getMainButtonIcon(recordingStatus.value),
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
    );
  }

  /// 녹음 상태에 따라 메인 버튼 아이콘 변경
  String _getMainButtonIcon(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.before:
        return Assets.iconsIconMic;
      case RecordingStatus.during:
        return Assets.iconsArrowLeft;
      case RecordingStatus.after:
        return Assets.iconsSend;
      default:
        return Assets.iconsIconMic;
    }
  }

  /// 하단 버튼들 (타이핑 모드 전환, 녹음 취소)
  Widget _buildBottomButtons(
    stt.SpeechToText speechToText,
    ValueNotifier<RecordingStatus> recordingStatus,
    ValueNotifier<String> recognizedText,
    ValueNotifier<bool> isListening,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTypingModeButton(),
            const Gap(48),
            _buildCancelButton(
                speechToText, recordingStatus, recognizedText, isListening),
          ],
        ),
      ),
    );
  }

  /// 타이핑 모드 전환 버튼
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

  /// 녹음 취소 버튼
  Widget _buildCancelButton(
    stt.SpeechToText speechToText,
    ValueNotifier<RecordingStatus> recordingStatus,
    ValueNotifier<String> recognizedText,
    ValueNotifier<bool> isListening,
  ) {
    return GestureDetector(
      onTap: () {
        if (recordingStatus.value == RecordingStatus.before) {
          print('녹음 취소 버튼이 현재 비활성화 되어있음');
        } else {
          resetRecognizedText(
              speechToText, recordingStatus, recognizedText, isListening);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: recordingStatus.value == RecordingStatus.before
              ? AppColor.of.background1
              : AppColor.of.red1,
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            Assets.iconsDeleteOrWrong,
            colorFilter: ColorFilter.mode(
              recordingStatus.value == RecordingStatus.before
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
