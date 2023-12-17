import 'package:techtalk/core/constants/stored_topics.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart'
    as interview;
import 'package:techtalk/features/interview/entities/qna_entity.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  const InterviewRepositoryImpl({
    required InterviewLocalDataSource interviewLocalDataSource,
    required InterviewRemoteDataSource interviewRemoteDataSource,
  })  : _interviewLocalDataSource = interviewLocalDataSource,
        _interviewRemoteDataSource = interviewRemoteDataSource;
  final InterviewLocalDataSource _interviewLocalDataSource;
  final InterviewRemoteDataSource _interviewRemoteDataSource;

  @override
  Future<Result<List<TopicEntity>>> getTopics() async {
    try {
      final remoteRes = await _interviewRemoteDataSource.getTopics();
      final result = remoteRes.map(TopicEntity.fromModel).toList();

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  }) async {
    try {
      final questionsModel =
          await _interviewRemoteDataSource.getReviewNoteQuestions(
        userUid: userUid,
        topicId: topicId,
      );

      final questionsEntity = questionsModel.map((e) {
        return InterviewQnAEntity(
          id: e.id,
          question: e.question,
          idealAnswer: e.answers,
          response: UserInterviewResponse(
            e.myAnswer,
            state: AnswerState.wrong,
          ),
        );
      }).toList();

      return Result.success(questionsEntity);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<interview.InterviewQuestionEntity>>> getInterviewQuestions(
    String topicId,
  ) async {
    List<InterviewQuestionModel> questionsModel;

    final cacheUpdateDate = await _interviewLocalDataSource
        .getCachedInterviewQuestionsUpdateDate(topicId);

    if (cacheUpdateDate != null) {
      final lastUpdateDate = await _interviewRemoteDataSource
          .getInterviewQuestionsUpdateDate(topicId);
      if (lastUpdateDate.compareTo(cacheUpdateDate) == 0) {
        questionsModel =
            (await _interviewLocalDataSource.getCachedQnaListOfTopic(topicId))!;
      } else {
        questionsModel =
            await _interviewRemoteDataSource.getQnaListOfTopic(topicId);
      }
    } else {
      questionsModel =
          await _interviewRemoteDataSource.getQnaListOfTopic(topicId);
    }

    return Result.success(
      questionsModel.map(interview.InterviewQuestionEntity.fromModel).toList(),
    );
  }

  @override
  Future<Result<List<QnaEntity>>> getQnaList(String topicId) async {
    try {
      final dateFromRemote = StoredTopics.getLastUpdatedDateById(topicId);
      final dateFromLocal =
          await _interviewLocalDataSource.getLastUpdatedDateByTopic(topicId);

      final List<QnaEntity> result;

      // 로컬에 데이터가 없거나
      // 로컬 날짜가 최신 날짜가 아니라면 원격으로부터 데이터 호출
      if (dateFromLocal == null || dateFromRemote.isAfter(dateFromLocal)) {
        final response = await _interviewRemoteDataSource.getQnaList(topicId);
        result = response.map(QnaEntity.fromModel).toList();

        return Result.success(result);
      }

      // 그외의 경우
      // 로컬에서 데이터를 호출
      final response = await _interviewRemoteDataSource.getQnaList(topicId);
      result = response.map(QnaEntity.fromModel).toList();

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
