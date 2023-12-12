import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/chat/data/remote/interview_chat_remote_data_source.dart';
import 'package:techtalk/features/interview_new/chat/interview_chat.dart';
import 'package:techtalk/features/interview_new/chat/repositories/interview_chat_repository.dart';
import 'package:techtalk/features/interview_new/topic/data/models/enum/interview_topic.enum.dart';

class InterviewChatRepositoryImpl implements InterviewChatRepository {
  const InterviewChatRepositoryImpl({
    required InterviewChatRemoteDataSource interviewRemoteDataSource,
  }) : _interviewRemoteDataSource = interviewRemoteDataSource;
  final InterviewChatRemoteDataSource _interviewRemoteDataSource;

  @override
  Future<Result<List<InterviewRoomEntity>>> getRooms(String topicId) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    final roomModels = await _interviewRemoteDataSource.getRooms(
      userUid: userUid,
      topicId: topicId,
    );
    final rooms = <InterviewRoomEntity>[];
    await Future.forEach(roomModels, (element) async {
      final latestMessageModel =
          await _interviewRemoteDataSource.getLastedRoomMessage(
        userUid: userUid,
        roomId: element.id,
      );

      rooms.add(
        InterviewRoomEntity(
          interviewerInfo: InterviewerAvatar.getAvatarInfoById(
            element.interviewerId,
          ),
          progressInfo: InterviewProgressInfoEntity(
            questionCount: element.questionCount,
            correctAnswerCount: element.correctAnswerCount,
            incorrectAnswerCount: element.incorrectAnswerCount,
          ),
          topic: InterviewTopicData.getTopicById(element.topicId),
          chatRoomId: element.id,
          lastChatDate: latestMessageModel.timestamp,
          lastChatMessage: latestMessageModel.message,
        ),
      );
    });

    return Result.success(rooms);
  }

  @override
  Future<Result<void>> createRoom(InterviewRoomEntity room) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await _interviewRemoteDataSource.createRoom(
        userUid: userUid,
        room: room,
      );

      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<InterviewMessageEntity>>> getChatHistory(
      String roomId) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final response = await _interviewRemoteDataSource.getChatHistory(
        userUid: userUid,
        roomId: roomId,
      );

      return Result.success([
        ...response.map((e) => e.toEntity()),
      ]);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateChatMessage({
    required String chatRoomId,
    required List<InterviewMessageEntity> messages,
  }) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final response = await _interviewRemoteDataSource.updateChatMessage(
        userUid: userUid,
        roomId: chatRoomId,
        messages: messages,
      );

      print("아지랑이 : ${messages.length}");

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
