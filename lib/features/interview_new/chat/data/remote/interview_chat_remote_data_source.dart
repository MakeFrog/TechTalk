import 'package:techtalk/features/interview_new/chat/data/models/interview_message_model.dart';
import 'package:techtalk/features/interview_new/chat/data/models/interview_room_model.dart';
import 'package:techtalk/features/interview_new/chat/interview_chat.dart';

abstract interface class InterviewChatRemoteDataSource {
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
