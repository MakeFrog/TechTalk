import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

///
/// 채팅 메세지 데이터 생성
///

final class CreateChatMessagesUseCase {
  CreateChatMessagesUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<void>> call({
    required String chatRoomId,
    required List<BaseChatEntity> messages,
  }) {
    return _repository.uploadChats(
      chatRoomId,
      messages: messages,
    );
  }
}
