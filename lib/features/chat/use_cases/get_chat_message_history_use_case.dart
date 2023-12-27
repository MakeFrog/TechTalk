import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetChatMessageHistoryUseCase
    extends BaseUseCase<String, Result<List<ChatMessageEntity>>> {
  GetChatMessageHistoryUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<ChatMessageEntity>>> call(String roomId) async {
    return _repository.getChatMessageHistory(roomId);
  }
}
