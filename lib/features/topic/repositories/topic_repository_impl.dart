import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/helper/date_time_extension.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_entity.dart';
import 'package:techtalk/features/topic/data_source/remote/models/wrong_answer_model.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicRepositoryImpl implements TopicRepository {
  TopicRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final TopicLocalDataSource _localDataSource;
  final TopicRemoteDataSource _remoteDataSource;

  List<TopicEntity>? _cachedTopics;
  List<TopicCategoryEntity>? _cachedTopicCategories;

  @override
  Future<void> initStaticData() async {
    final topicModels = await _remoteDataSource.getTopics();
    _cachedTopics ??= topicModels.map((e) => e.toEntity()).toList();

    final categoryModels = await _localDataSource.getTopicCategories();
    _cachedTopicCategories ??= categoryModels.map((e) => e.toEntity()).toList();
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
        topicId: chatQna.id.getFirstPartOfSpliited,
      );
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(const WrongAnswerUpdateFailedException());
    }
  }
}
