import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class CreateChatRoomUseCase {
  CreateChatRoomUseCase(this._chatRepository);
  final ChatRepository _chatRepository;

  Future<Result<void>> call({
    required ChatRoomEntity room,
    required List<ChatQnaEntity> qnas,
    required List<ChatMessageEntity> messages,
  }) async {
    return _chatRepository.createChatRoom(
      room: room,
      qnas: qnas,
      messages: messages,
    );
  }
}
