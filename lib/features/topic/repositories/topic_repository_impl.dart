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

  List<TopicEntity>? _cachedTopics;
  List<TopicCategoryEntity>? _cachedTopicCategories;

  @override
  Future<void> initStaticData() async {
    _cachedTopics ??= await _remoteDataSource.getTopics().then(
          (value) => value.map((e) => e.toEntity()).toList(),
        );
    _cachedTopicCategories ??= await _localDataSource.getTopicCategories().then(
          (value) => value.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Result<List<TopicEntity>> getTopics() {
    try {
      return Result.success(_cachedTopics!);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<TopicEntity> getTopic(String id) {
    try {
      return Result.success(
        _cachedTopics!.firstWhere((element) => element.id == id),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<List<TopicCategoryEntity>> getTopicCategories() {
    try {
      return Result.success(_cachedTopicCategories!);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<TopicCategoryEntity> getTopicCategory(String id) {
    try {
      return Result.success(
        _cachedTopicCategories!.firstWhere((element) => element.id == id),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TopicQnaEntity>>> getTopicQnas(
    String topicId,
  ) async {
    try {
      final questionsModel = await _localDataSource.getQnas(topicId) ??
          await _remoteDataSource.getQnas(topicId);

      return Result.success(
        questionsModel.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(
        NoTopicQuestionException(topicId),
      );
    }
  }

  @override
  Future<Result<TopicQnaEntity>> getTopicQna(
    String topicId,
    String questionId,
  ) async {
    try {
      final questionModel = await _localDataSource.getQna(
            topicId,
            questionId,
          ) ??
          await _remoteDataSource.getQna(
            topicId,
            questionId,
          );

      return Result.success(questionModel.toEntity());
    } on Exception catch (e) {
      return Result.failure(
        NoTopicQuestionException(topicId),
      );
    }
  }
}
