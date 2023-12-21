import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
  @override
  Future<List<TopicModel>> getTopics() async {
    final topicModels = await FirestoreCollections.topics
        .collection()
        .withConverter(
          fromFirestore: TopicModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    return [
      ...topicModels.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<TopicModel> getTopic(String id) async {
    final topicModel = await FirestoreCollections.topics
        .doc(id)
        .withConverter(
          fromFirestore: TopicModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    return topicModel.data()!;
  }

  @override
  Future<List<TopicCategoryModel>> getTopicCategories() async {
    final topicCategoryModels = await FirestoreCollections.topicCategories
        .collection()
        .withConverter(
          fromFirestore: TopicCategoryModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    return [
      ...topicCategoryModels.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<TopicCategoryModel> getTopicCategory(String id) async {
    final topicCategoryModel = await FirestoreCollections.topicCategories
        .doc(id)
        .withConverter(
          fromFirestore: TopicCategoryModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    return topicCategoryModel.data()!;
  }

  @override
  Future<TopicQuestionModel> getQuestion(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await FirestoreCollections.topics
        .question(topicId)
        .doc(questionId)
        .withConverter(
          fromFirestore: TopicQuestionModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (!snapshot.exists) {
      throw Exception();
    }

    return snapshot.data()!;
  }

  @override
  Future<List<TopicQuestionModel>> getQuestions(String topicId) async {
    final snapshot = await FirestoreCollections.topics
        .question(topicId)
        .collection()
        .withConverter(
          fromFirestore: TopicQuestionModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    return [...snapshot.docs.map((e) => e.data())];
  }
}
