import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
  @override
  Future<List<TopicModel>> getTopics() async {
    final topicModels = await FirestoreTopicRef.collection()
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
  Future<List<TopicCategoryModel>> getTopicCategories() async {
    final topicCategoryModels = await FirestoreTopicCategoryRef.collection()
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
  Future<TopicQnaModel> getQna(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await FirestoreTopicQuestionRef.doc(topicId, questionId)
        .withConverter(
          fromFirestore: TopicQnaModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (!snapshot.exists) {
      throw Exception();
    }

    return snapshot.data()!;
  }

  @override
  Future<List<TopicQnaModel>> getQnas(String topicId) async {
    final snapshot = await FirestoreTopicQuestionRef.collection(topicId)
        .withConverter(
          fromFirestore: TopicQnaModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }
}
