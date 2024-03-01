import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_progress.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

part 'interview_progress_state_provider.g.dart';

@Riverpod(dependencies: [SelectedChatRoom, ChatMessageHistory])
class InterviewProgressState extends _$InterviewProgressState {
  @override
  InterviewProgress build() {
    final roomProgress = ref.read(selectedChatRoomProvider).progressState;

    if (roomProgress.isCompleted) return InterviewProgress.done;

    listenMessageChanges();

    if (roomProgress.isOngoing) {
      return InterviewProgress.readyToAnswer;
    } else {
      return InterviewProgress.initial;
    }
  }

  ///
  /// 채팅 메세지 리스트를 listen하여
  /// 채팅 인터뷰 진행 상태를 조건별로 업데이트
  ///
  void listenMessageChanges() {
    ref.listen(chatMessageHistoryProvider, (prev, chatHistory) {
      if (chatHistory.value == null) return;

      final lastChat = chatHistory.value!.first;

      switch (lastChat.type) {
        case ChatType.guide:
          if (ref.read(selectedChatRoomProvider).progressState.isCompleted) {
            state = InterviewProgress.done;
          }

        case ChatType.question:
          lastChat.message.listen(
            null,
            onDone: () {
              state = InterviewProgress.readyToAnswer;
            },
          );

        case ChatType.feedback:
          if (ref.read(selectedChatRoomProvider.notifier).isLastQuestion()) {
            FirebaseAnalytics.instance.logEvent(
              name: 'Interview Completed',
              parameters: {
                'user_id': ref.read(userInfoProvider).requireValue?.uid,
                'user_name': ref.read(userInfoProvider).requireValue?.nickname,
                'topics': ref
                    .read(selectedChatRoomProvider)
                    .topics
                    .map((e) => e.text)
                    .join(', '),
                'interview_type': ref.read(selectedChatRoomProvider).type.name,
                'passOrFail':
                    ref.read(selectedChatRoomProvider).passOrFail.name,
              },
            );

            state = InterviewProgress.done;
          }
        default:
          state = InterviewProgress.interviewerReplying;
      }
    });
  }
}
