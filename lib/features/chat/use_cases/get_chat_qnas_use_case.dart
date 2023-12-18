import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class GetChatQnAsUseCase {
  GetChatQnAsUseCase(this._chatRepository);

  final ChatRepository _chatRepository;
  Future<Result<List<InterviewQnAEntity>>> call(String roomId) async {
    return _chatRepository.getChatQnAs(roomId);
  }
}
