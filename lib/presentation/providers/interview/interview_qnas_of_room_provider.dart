import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/providers/interview/chat_history_of_room_provider.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_room_provider.dart';

part 'interview_qnas_of_room_provider.g.dart';

@riverpod
class InterviewQnAsOfRoom extends _$InterviewQnAsOfRoom {
  @override
  FutureOr<List<InterviewQnAEntity>> build() async {
    final room = ref.watch(selectedInterviewRoomProvider);
    final interviewChatHistory =
        await ref.watch(chatHistoryOfRoomProvider.future);

    if (interviewChatHistory.isNotEmpty) {
      // final qnas = await getQnAsOfRoomUseCase(room);
      // return qnas.fold(
      //   onSuccess: (value) => value,
      //   onFailure: (e) {
      //     throw e;
      //   },
      // );
    }
    return [];
  }
}
