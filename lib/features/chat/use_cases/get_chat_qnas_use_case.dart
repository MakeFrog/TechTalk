import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class GetChatQnasUseCase {
  GetChatQnasUseCase(this._chatRepository);

  final ChatRepository _chatRepository;
  Future<Result<List<ChatQnaEntity>>> call(ChatRoomEntity room) async {
    return _chatRepository.getChatQnAs(room);
  }
}
