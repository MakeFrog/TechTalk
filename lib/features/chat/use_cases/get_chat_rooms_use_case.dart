import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/core/utils/result.dart';
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
