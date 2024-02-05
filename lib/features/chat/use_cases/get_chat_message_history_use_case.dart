import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/entities/chat_history_collection_entity.dart';

class GetChatMessageHistoryUseCase
    extends BaseUseCase<String, Result<ChatHistoryCollectionEntity>> {
  GetChatMessageHistoryUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<ChatHistoryCollectionEntity>> call(String roomId) async {
    return _repository.getChatMessageHistory(roomId);
  }
}
