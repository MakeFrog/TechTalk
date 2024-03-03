import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetChatMessageHistoryUseCase
    extends BaseUseCase<String, Result<ChatHistoryCollectionEntity>> {
  GetChatMessageHistoryUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<ChatHistoryCollectionEntity>> call(String roomId) async {
    return _repository.getChatHistory(roomId);
  }
}
