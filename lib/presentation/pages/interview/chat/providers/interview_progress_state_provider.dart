import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_qnas_of_room_provider.dart';

part 'interview_progress_state_provider.g.dart';

@Riverpod()
class InterviewProgressState extends _$InterviewProgressState {
  @override
  InterviewProgress build(ChatRoomEntity room) {
    final qnas = ref.watch(interviewQnAsOfRoomProvider(room)).valueOrNull;
    if (qnas != null) {
      final totalQuestionCount = qnas.length;
      final completedQnAs = qnas.where(
        (e) => e.hasUserResponded && e.response!.state.isCompleted,
      );

      if (completedQnAs.length >= totalQuestionCount) {
        return InterviewProgress.done;
      }
    }

    ref.listen(
      chatHistoryOfRoomProvider(room),
      (_, next) {
        if (next.hasValue) {
          final lastChat = next.requireValue.first;
          switch (lastChat.type) {
            case ChatType.userReply:
            case ChatType.guide:
            case ChatType.feedback:
              state = InterviewProgress.interviewerReplying;
            case ChatType.askQuestion:
              lastChat.message.listen(
                null,
                onDone: () {
                  state = InterviewProgress.readyToAnswer;
                },
              );
          }
        }
      },
    );

    return InterviewProgress.initial;
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
