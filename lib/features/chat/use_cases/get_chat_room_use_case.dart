import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class GetChatRoomUseCase {
  GetChatRoomUseCase(
    this.chatRepository,
  );

  final ChatRepository chatRepository;

  Future<Result<ChatRoomEntity>> call(String roomId) async {
    return chatRepository.getChatRoom(roomId);
  }
}
