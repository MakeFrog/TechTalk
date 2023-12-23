import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class CreateChatRoomUseCase {
  CreateChatRoomUseCase(this._chatRepository);

  final ChatRepository _chatRepository;
  Future<Result<void>> call(ChatRoomEntity room) async {
    return _chatRepository.createRoom(room);
  }
}
