import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';

class GetChatListUseCase {
  GetChatListUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<List<ChatEntity>>> call(String roomId) =>
      _repository.getChatList(roomId);
}
