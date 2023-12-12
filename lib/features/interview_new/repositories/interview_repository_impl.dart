import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/data/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview_new/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview_new/data/remote/interview_remote_data_source.dart';
import 'package:techtalk/features/interview_new/entities/interview_progress_info_entity.dart';
import 'package:techtalk/features/interview_new/entities/interview_qna_entity.dart';
import 'package:techtalk/features/interview_new/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview_new/entities/interview_room_entity.dart';
import 'package:techtalk/features/interview_new/entities/interview_topic.enum.dart';
import 'package:techtalk/features/interview_new/entities/interviewer_avatar.dart';
import 'package:techtalk/features/interview_new/entities/messages/interview_message_entity.dart';
import 'package:techtalk/features/interview_new/entities/states/answer_state.enum.dart';
import 'package:techtalk/features/interview_new/repositories/interview_repository.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  const InterviewRepositoryImpl({
    required InterviewLocalDataSource interviewLocalDataSource,
    required InterviewRemoteDataSource interviewRemoteDataSource,
  })  : _interviewLocalDataSource = interviewLocalDataSource,
        _interviewRemoteDataSource = interviewRemoteDataSource;
  final InterviewLocalDataSource _interviewLocalDataSource;
  final InterviewRemoteDataSource _interviewRemoteDataSource;

  @override
  Result<List<InterviewTopic>> getTopics() {
    return Result.success(InterviewTopic.values);
  }

  @override
  Future<Result<List<InterviewQnAEntity>>> getQnAsOfTopic({
    required String userUid,
    required String topicId,
  }) async {
    try {
      final qnaModels = await _interviewRemoteDataSource.getQnAsOfTopic(
        userUid: userUid,
        topicId: topicId,
      );

      final qnas = <InterviewQnAEntity>[];
      await Future.forEach(qnaModels, (element) async {
        final questionModel =
            await _interviewRemoteDataSource.getQuestionOfTopic(
          topicId,
          element.questionId,
        );
        qnas.add(
          InterviewQnAEntity(
            question: InterviewQuestionEntity.fromModel(questionModel),
            answer: element.answer,
            answerState: AnswerState.getStateById(element.answerState),
          ),
        );
      });

      return Result.success(qnas);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<InterviewQuestionEntity>>> getQuestionsOfTopic(
    String topicId,
  ) async {
    try {
      List<InterviewQuestionModel> questionsModel;

      final cacheUpdateDate =
          await _interviewLocalDataSource.getUpdateDateOfTopic(topicId);

      if (cacheUpdateDate != null) {
        final lastUpdateDate =
            await _interviewRemoteDataSource.getUpdateDateOfTopic(topicId);
        if (lastUpdateDate.compareTo(cacheUpdateDate) == 0) {
          questionsModel =
              (await _interviewLocalDataSource.getQuestionsOfTopic(topicId))!;
        } else {
          questionsModel =
              await _interviewRemoteDataSource.getQuestionsOfTopic(topicId);
        }
      } else {
        questionsModel =
            await _interviewRemoteDataSource.getQuestionsOfTopic(topicId);
      }

      return Result.success(
        [
          ...questionsModel.map(InterviewQuestionEntity.fromModel),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

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
          topic: InterviewTopic.getTopicById(element.topicId),
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
