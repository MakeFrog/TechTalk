import 'package:techtalk/core/modules/base_use_case/base_use_case.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_history_collection_entity.dart';

class GetChatMessageHistoryUseCase
    extends BaseUseCase<String, Result<ChatHistoryCollectionEntity>> {
  GetChatMessageHistoryUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<ChatHistoryCollectionEntity>> call(String roomId) async {
    return _repository.getChatHistory(roomId);
  }
}
