import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/chat/entities/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<Result<String>> createRoom({
    required String topicId,
    required int questionCount,
  }) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final roomId = await _remoteDataSource.createRoom(
      userUid: userUid,
      topicId: topicId,
      questionCount: questionCount,
    );

    return Result.success(roomId);
  }

  @override
  Future<Result<List<ChatRoomEntity>>> getRooms(String topicId) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final roomModels = await _remoteDataSource.getRooms(
        userUid,
        topicId,
      );
      final asyncResult = roomModels.map((e) async {
        final messageResponse = await _remoteDataSource.getLastChat(
          userUid,
          e.chatRoomId,
        );

        return ChatRoomEntity(
          chatRoomId: e.chatRoomId,
          interviewerInfo: InterviewerAvatar.getAvatarInfoById(e.interviewerId),
          topic: topicRepository.getTopic(topicId).getOrThrow(),
          qnaProgressInfo: ChatQnaProgressInfoEntity(
            totalQuestionCount: e.totalQuestionCount,
            correctAnswerCount: e.correctAnswerCount,
            incorrectAnswerCount: e.incorrectAnswerCount,
          ),
        ).copyWith(
          lastChatMessage: messageResponse?.message,
          lastChatDate: messageResponse?.timestamp,
        );
      });
      final rooms = await Future.wait(asyncResult);
      rooms.sort(
        (a, b) => a.lastChatDate == null || b.lastChatDate == null
            ? 1
            : b.lastChatDate!.compareTo(a.lastChatDate!),
      );

      return Result.success(rooms);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChatRoomEntity>> getRoom(String roomId) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final roomModel = await _remoteDataSource.getRoom(
      userUid,
      roomId,
    );

    return Result.success(
      ChatRoomEntity(
        chatRoomId: roomModel.chatRoomId,
        interviewerInfo:
            InterviewerAvatar.getAvatarInfoById(roomModel.interviewerId),
        topic: topicRepository.getTopic(roomModel.topicId).getOrThrow(),
        qnaProgressInfo: ChatQnaProgressInfoEntity(
          totalQuestionCount: roomModel.totalQuestionCount,
          correctAnswerCount: roomModel.correctAnswerCount,
          incorrectAnswerCount: roomModel.incorrectAnswerCount,
        ),
      ),
    );
  }

  @override
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final messageModels = await _remoteDataSource.getChatHistory(
        userUid,
        roomId,
      );

      return Result.success([
        ...messageModels.map((e) => e.toEntity()),
      ]);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateMessages(
    String roomId, {
    required List<MessageEntity> messages,
  }) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final response = await _remoteDataSource.updateChats(
        userUid,
        roomId,
        messages: messages,
      );

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<InterviewQnAEntity>>> getChatQnAs(
    String roomId,
  ) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final roomModel = await _remoteDataSource.getRoom(
      userUid,
      roomId,
    );
    final roomQnAs = await _remoteDataSource.getChatQnAs(
      userUid,
      roomId,
    );

    final qnas = <InterviewQnAEntity>[];
    await Future.forEach(roomQnAs, (element) async {
      // 질문 조회
      final question = (await topicRepository.getTopicQuestion(
        roomModel.topicId,
        element.questionId,
      ))
          .getOrThrow();
      // 응답 id가 있으면 응답 데이터 조회
      final SentMessageEntity? answer;
      if (element.messageId != null) {
        final messageModel = await _remoteDataSource.getChat(
          userUid,
          roomId,
          element.messageId!,
        );
        answer = messageModel.toEntity() as SentMessageEntity;
      } else {
        answer = null;
      }

      qnas.add(
        InterviewQnAEntity(
          id: element.id,
          question: question,
          response: answer != null
              ? UserInterviewResponse(
                  answer.message.value,
                  state: answer.answerState,
                )
              : null,
        ),
      );
    });

    return Result.success(qnas);
  }
}
