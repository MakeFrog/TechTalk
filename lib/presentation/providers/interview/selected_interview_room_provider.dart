import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'selected_interview_room_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedInterviewRoom extends _$SelectedInterviewRoom {
  @override
  ChatRoomEntity? build() => null;

  Future<void> update(String roomId) async {
    state = (await getInterviewRoomUseCase(roomId)).getOrThrow();
  }
}
