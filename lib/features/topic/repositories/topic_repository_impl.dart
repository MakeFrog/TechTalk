import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicRepositoryImpl implements TopicRepository {
  const TopicRepositoryImpl({
    required TopicLocalDataSource localDataSource,
    required TopicRemoteDataSource remoteDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final TopicLocalDataSource _localDataSource;
  final TopicRemoteDataSource _remoteDataSource;

  @override
  Result<List<Topic>> getTopics() {
    return Result.success(Topic.values);
  }

  @override
  Result<List<Topic>> searchTopics(String keyword) {
    return Result.success(
      [
        ...Topic.values.where(
          (e) => e.text.toLowerCase().startsWith(
                keyword.toLowerCase(),
              ),
        ),
      ],
    );
  }

  @override
  Future<Result<List<TopicQuestionEntity>>> getTopicQuestions(
    String topicId,
  ) async {
    List<TopicQuestionModel> questionsModel;
    try {
      final cacheUpdateDate = await _localDataSource.getUpdateDate(topicId);

      if (cacheUpdateDate != null) {
        final lastUpdateDate = await _remoteDataSource.getUpdateDate(topicId);
        if (lastUpdateDate.compareTo(cacheUpdateDate) == 0) {
          questionsModel = (await _localDataSource.getQuestions(topicId))!;
        } else {
          questionsModel = await _remoteDataSource.getQuestions(topicId);
        }
      } else {
        questionsModel = await _remoteDataSource.getQuestions(topicId);
      }

      return Result.success(
        [
          ...questionsModel.map((e) => e.toEntity()),
        ],
      );
    } on Exception catch (e) {
      final topic = Topic.getTopicById(topicId);

      return Result.failure(
        NoTopicQuestionException(topic.text),
      );
    }
  }

  @override
  Future<Result<TopicQuestionEntity>> getTopicQuestion(
    String topicId,
    String questionId,
  ) async {
    try {
      final questionModel = await _remoteDataSource.getQuestion(
        topicId,
        questionId,
      );

      return Result.success(
        questionModel.toEntity(),
      );
    } on Exception catch (e) {
      final topic = Topic.getTopicById(topicId);

      return Result.failure(
        NoTopicQuestionException(topic.text),
      );
    }
  }
}
