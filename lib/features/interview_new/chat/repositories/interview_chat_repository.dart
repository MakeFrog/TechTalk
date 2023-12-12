import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/interview.dart';

abstract interface class InterviewChatRepository {
  Future<Result<void>> createRoom(InterviewRoomEntity room);
  Future<Result<List<InterviewRoomEntity>>> getRooms(String topicId);
  Future<Result<List<InterviewMessageEntity>>> getChatHistory(String roomId);
  Future<Result<void>> updateChatMessage({
    required String chatRoomId,
    required List<InterviewMessageEntity> messages,
  });
}
