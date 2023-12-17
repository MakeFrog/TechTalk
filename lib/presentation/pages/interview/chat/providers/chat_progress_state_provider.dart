import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/completed_qna_list_provider.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_room_provider.dart';

part 'chat_progress_state_provider.g.dart';

@Riverpod(
  dependencies: [
    ChatHistory,
  ],
)
class ChatProgressState extends _$ChatProgressState {
  @override
  ChatProgress build() {
    final completedQnaListener =
        ref.listen(completedQnAListProvider, (_, next) {
      final totalQuestionCount = ref
          .read(selectedInterviewRoomProvider)!
          .qnaProgressInfo
          .totalQuestionCount;
      if (next.requireValue.length >= totalQuestionCount) {
        state = ChatProgress.done;
      }
    });

    final historyListener = ref.listen(
      chatHistoryProvider,
      (_, next) {
        final lastChat = next.requireValue.first;
        if (lastChat.type.isAskQuestionMessage) {
          lastChat.message.listen(
            null,
            onDone: () {
              state = ChatProgress.readyToAnswer;
            },
          );
        }
      },
    );

    ref.onDispose(() {
      completedQnaListener.close();
      historyListener.close();
    });

    return ChatProgress.initial;
  }

  void changeState(ChatProgress passState) {
    state = passState;
  }
}

enum ChatProgress {
  initial('잠시만 기다려주세요', false),
  readyToAnswer('답변을 입력해주세요', true),
  interviewerReplying('잠시만 기다려주세요', false),
  done('면접이 종료되었습니다', false);

  final String fieldHintText;
  final bool enableChat;

  const ChatProgress(this.fieldHintText, this.enableChat);

  bool get isChatAvailable => this == ChatProgress.readyToAnswer;
}
