import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class GetChatRoomsUseCase {
  GetChatRoomsUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<List<ChatRoomEntity>>> call(
    InterviewType type, [
    TopicEntity? topic,
  ]) {
    return _repository.getChatRooms(type, topic);
  }
}
