import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';

part 'interview_progress_state_provider.g.dart';

@Riverpod(dependencies: [selectedChatRoom, ChatQnas, ChatMessageHistory])
class InterviewProgressState extends _$InterviewProgressState {
  @override
  InterviewProgress build() {
    final progressState = ref.read(selectedChatRoomProvider).progressState;

    if (progressState.isCompleted) {
      return InterviewProgress.done;
    } else {
      _listenStateBasedOnChatHistory();
      if (progressState.isInitial) return InterviewProgress.initial;
      if (progressState.isOngoing) return InterviewProgress.readyToAnswer;
    }

    return InterviewProgress.readyToAnswer;
  }

  void _listenStateBasedOnChatHistory() {
    ref.listen(chatMessageHistoryProvider, (_, chatHistory) {
      final lastChat = chatHistory.value!.first;
      switch (lastChat.type) {
        case ChatType.guide:
        case ChatType.question:
          lastChat.message.listen(
            null,
            onDone: () {
              state = InterviewProgress.readyToAnswer;
            },
          );
        default:
          state = InterviewProgress.interviewerReplying;
      }
    });
  }
}

enum InterviewProgress {
  initial,
  readyToAnswer,
  interviewerReplying,
  done;

  String get fieldHintText => switch (this) {
        InterviewProgress.initial => '잠시만 기다려주세요',
        InterviewProgress.readyToAnswer => '답변을 입력해주세요',
        InterviewProgress.interviewerReplying => '잠시만 기다려주세요',
        InterviewProgress.done => '면접이 종료되었습니다',
      };

  bool get enableChat => switch (this) {
        InterviewProgress.initial => false,
        InterviewProgress.readyToAnswer => true,
        InterviewProgress.interviewerReplying => false,
        InterviewProgress.done => false,
      };
}
