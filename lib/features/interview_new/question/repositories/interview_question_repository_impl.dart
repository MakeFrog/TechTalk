import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/question/data/local/interview_question_local_data_source.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview_new/question/data/remote/interview_question_remote_data_source.dart';
import 'package:techtalk/features/interview_new/question/interview_question.dart';
import 'package:techtalk/features/interview_new/question/repositories/interview_question_repository.dart';

class InterviewQuestionRepositoryImpl implements InterviewQuestionRepository {
  const InterviewQuestionRepositoryImpl({
    required InterviewQuestionLocalDataSource interviewLocalDataSource,
    required InterviewQuestionRemoteDataSource interviewRemoteDataSource,
  })  : _interviewLocalDataSource = interviewLocalDataSource,
        _interviewRemoteDataSource = interviewRemoteDataSource;
  final InterviewQuestionLocalDataSource _interviewLocalDataSource;
  final InterviewQuestionRemoteDataSource _interviewRemoteDataSource;

  @override
  Future<Result<List<InterviewQuestionEntity>>> getQuestions(
    String topicId,
  ) async {
    try {
      List<InterviewQuestionModel> questionsModel;

      final cacheUpdateDate =
          await _interviewLocalDataSource.getUpdateDate(topicId);

      if (cacheUpdateDate != null) {
        final lastUpdateDate =
            await _interviewRemoteDataSource.getUpdateDate(topicId);
        if (lastUpdateDate.compareTo(cacheUpdateDate) == 0) {
          questionsModel =
              (await _interviewLocalDataSource.getQuestions(topicId))!;
        } else {
          questionsModel =
              await _interviewRemoteDataSource.getQuestions(topicId);
        }
      } else {
        questionsModel = await _interviewRemoteDataSource.getQuestions(topicId);
      }

      return Result.success(
        [
          ...questionsModel.map((e) => e.toEntity()),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  FutureOr<Result<InterviewQuestionEntity>> getQuestion(
    String topicId,
    String questionId,
  ) async {
    try {
      InterviewQuestionModel questionModel;

      final cacheUpdateDate =
          await _interviewLocalDataSource.getUpdateDate(topicId);

      if (cacheUpdateDate != null) {
        final lastUpdateDate =
            await _interviewRemoteDataSource.getUpdateDate(topicId);
        if (lastUpdateDate.compareTo(cacheUpdateDate) == 0) {
          questionModel = (await _interviewLocalDataSource.getQuestion(
            topicId,
            questionId,
          ))!;
        } else {
          questionModel = await _interviewRemoteDataSource.getQuestion(
            topicId,
            questionId,
          );
        }
      } else {
        questionModel = await _interviewRemoteDataSource.getQuestion(
          topicId,
          questionId,
        );
      }

      return Result.success(questionModel.toEntity());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  FutureOr<Result<List<InterviewAnswerEntity>>> getAnswers(
    String topicId,
    String questionId,
  ) async {
    try {
      final answerModels = await _interviewRemoteDataSource.getAnswers(
        topicId,
        questionId,
      );

      return Result.success(
        [
          ...answerModels.map((e) => e.toEntity()),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
