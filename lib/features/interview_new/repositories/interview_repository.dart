import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/interview.dart';

abstract interface class InterviewRepository {
  Result<List<InterviewTopic>> getTopics();

  Future<Result<List<InterviewQnAEntity>>> getQnAsOfTopic({
    required String userUid,
    required String topicId,
  });

  Future<Result<List<InterviewQuestionEntity>>> getQuestionsOfTopic(
    String topicId,
  );
  Future<Result<void>> createRoom(InterviewRoomEntity room);

  Future<Result<List<InterviewRoomEntity>>> getRooms(String topicId);
  Future<Result<List<InterviewMessageEntity>>> getChatHistory(String roomId);
  Future<Result<void>> updateChatMessage({
    required String chatRoomId,
    required List<InterviewMessageEntity> messages,
  });
}
