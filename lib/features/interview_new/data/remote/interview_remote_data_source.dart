import 'package:techtalk/features/interview_new/data/models/interview_message_model.dart';
import 'package:techtalk/features/interview_new/data/models/interview_qna_model.dart';
import 'package:techtalk/features/interview_new/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview_new/data/models/interview_room_model.dart';
import 'package:techtalk/features/interview_new/interview.dart';

abstract interface class InterviewRemoteDataSource {
  Future<List<InterviewQnaModel>> getQnAsOfTopic({
    required String userUid,
    required String topicId,
  });
  Future<DateTime> getUpdateDateOfTopic(String topicId);
  Future<List<InterviewQuestionModel>> getQuestionsOfTopic(String topicId);
  Future<InterviewQuestionModel> getQuestionOfTopic(
    String topicId,
    String questionId,
  );

  Future<void> createRoom({
    required String userUid,
    required InterviewRoomEntity room,
  });

  Future<List<InterviewRoomModel>> getRooms({
    required String userUid,
    required String topicId,
  });
  Future<InterviewMessageModel> getLastedRoomMessage({
    required String userUid,
    required String roomId,
  });
  Future<List<InterviewMessageModel>> getChatHistory({
    required String userUid,
    required String roomId,
  });

  Future<void> updateChatMessage({
    required String userUid,
    required String roomId,
    required List<InterviewMessageEntity> messages,
  });
}
