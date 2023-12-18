import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'interview_qnas_of_room_provider.g.dart';

@riverpod
class InterviewQnAsOfRoom extends _$InterviewQnAsOfRoom {
  @override
  FutureOr<List<InterviewQnAEntity>> build(ChatRoomEntity room) async {
    final qnas = await getChatQnAsUseCase(
      room.chatRoomId,
    );

    return qnas.getOrThrow();
  }
}
