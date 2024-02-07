import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
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
