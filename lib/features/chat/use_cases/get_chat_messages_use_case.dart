import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetChatMessagesUseCase
    extends BaseUseCase<String, Result<List<MessageEntity>>> {
  GetChatMessagesUseCase(this._repository);

  final ChatRepository _repository;

  @override
  Future<Result<List<MessageEntity>>> call(String roomId) async {
    return _repository.getChatHistory(roomId);
  }
}
