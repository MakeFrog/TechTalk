import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart'
    as interview;
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
  Result<List<InterviewTopic>> getTopics() {
    try {
      final response = _interviewLocalDataSource.getTopics();
      return Result.success(response);
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
        questionsModel = (await _interviewLocalDataSource
            .getCachedInterviewQuestions(topicId))!;
      } else {
        questionsModel =
            await _interviewRemoteDataSource.getInterviewQuestions(topicId);
      }
    } else {
      questionsModel =
          await _interviewRemoteDataSource.getInterviewQuestions(topicId);
    }

    return Result.success(
      questionsModel.map(interview.InterviewQuestionEntity.fromModel).toList(),
    );
  }
}
