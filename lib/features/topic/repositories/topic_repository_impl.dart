import 'dart:developer';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicRepositoryImpl implements TopicRepository {
  TopicRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final TopicLocalDataSource _localDataSource;
  final TopicRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<QnaEntity>>> getTopicQnas(
    String topicId,
  ) async {
    try {
      final targetTopic = StoredTopics.getById(topicId);
      final localResponse = _localDataSource.loadQnas(topicId);

      if (localResponse != null &&
          localResponse.updatedAt.isAfterOrSameAs(targetTopic.updatedAt)) {
        return Result.success(
          localResponse.items.map((e) => e.toEntity()).toList(),
        );
      } else {
        final remoteResponse = await _remoteDataSource.getQnas(topicId);
        await _localDataSource.storeQnas(
            topicId: topicId, qnas: remoteResponse);
        return Result.success(
          remoteResponse.map((e) => e.toEntity()).toList(),
        );
      }
    } on Exception catch (e) {
      log('getTopicQnas : $e');
      return Result.failure(
        NoTopicQuestionException(topicId),
      );
    }
  }

  @override
  Future<Result<QnaEntity>> getTopicQna(
    String topicId,
    String questionId,
  ) async {
    try {
      final localResponse =
          _localDataSource.loadSingleQna(topicId: topicId, qnaId: questionId);

      if (localResponse != null) {
        return Result.success(localResponse.toEntity());
      } else {
        final remoteResponse =
            await _remoteDataSource.getQna(topicId, questionId);

        return Result.success(
          remoteResponse.toEntity(),
        );
      }
    } on Exception catch (e) {
      log('getTopicQna : $e');
      return Result.failure(
        NoTopicQuestionException(topicId),
      );
    }
  }

  @override
  Future<Result<void>> updateWrongAnswer(ChatQnaEntity chatQna) async {
    try {
      await _remoteDataSource.updateWrongAnswer(
        wrongAnswer: WrongAnswerModel.fromEntity(chatQna),
        topicId: chatQna.qna.id.getFirstPartOfSpliited,
      );
      return Result.success(null);
    } on Exception catch (e) {
      log('updateWrongAnswer : $e');
      return Result.failure(const WrongAnswerUpdateFailedException());
    }
  }

  @override
  Future<Result<List<WrongAnswerEntity>>> getWrongAnswers(
      String topicId) async {
    try {
      final response = await _remoteDataSource.getWrongAnswers(topicId);
      final futureResults = response.map((e) async {
        final qnaResponse = await getTopicQna(topicId, e.id);
        return e.toEntity(qnaResponse.getOrThrow());
      }).toList();

      return Result.success(await Future.wait(futureResults));
    } on Exception catch (e) {
      log('getWrongAnswers : $e');
      return Result.failure(const WrongAnswerUpdateFailedException());
    }
  }

  @override
  Future<Result<void>> deleteUserWrongAnswers() async {
    try {
      final response = await _remoteDataSource.deleteUserWrongAnswers();
      return Result.success(response);
    } on Exception catch (e) {
      log('deleteUserWrongAnswers : $e');
      return Result.failure(e);
    }
  }
}
