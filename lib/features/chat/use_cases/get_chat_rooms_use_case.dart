import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

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
