import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class GetChatQnasUseCase {
  GetChatQnasUseCase(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Result<List<ChatQnaEntity>>> call(ChatRoomEntity room) async {
    return room.type.typedBranch(
      common: (_) => _chatRepository.getCommonChatQnas(room),
      resume: (_) => _chatRepository.getResumeChatQnas(room),
    );
  }
}
