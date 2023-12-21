import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicRepositoryImpl implements TopicRepository {
  TopicRepositoryImpl({
    required TopicLocalDataSource localDataSource,
    required TopicRemoteDataSource remoteDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final TopicLocalDataSource _localDataSource;
  final TopicRemoteDataSource _remoteDataSource;

  late final List<TopicEntity> _cachedTopics;
  late final List<TopicCategoryEntity> _cachedTopicCategories;

  @override
  Future<void> initCache() async {
    _cachedTopics = await _remoteDataSource.getTopics().then(
          (value) => value.map((e) => e.toEntity()).toList(),
        );
    _cachedTopicCategories = await _remoteDataSource.getTopicCategories().then(
          (value) => value.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Result<List<TopicEntity>> getTopics() {
    try {
      return Result.success(_cachedTopics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<TopicEntity> getTopic(String id) {
    try {
      return Result.success(
        _cachedTopics.firstWhere((element) => element.id == id),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<List<TopicCategoryEntity>> getTopicCategories() {
    try {
      return Result.success(_cachedTopicCategories);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<TopicCategoryEntity> getTopicCategory(String id) {
    try {
      return Result.success(
        _cachedTopicCategories.firstWhere((element) => element.id == id),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TopicQuestionEntity>>> getTopicQuestions(
    String topicId,
  ) async {
    try {
      final questionsModel = await _localDataSource.getQuestions(topicId) ??
          await _remoteDataSource.getQuestions(topicId);

      return Result.success(
        [
          ...questionsModel.map((e) => e.toEntity()),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(
        NoTopicQuestionException(topicId),
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
      return Result.failure(
        NoTopicQuestionException(topicId),
      );
    }
  }
}
