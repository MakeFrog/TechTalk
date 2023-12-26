import 'package:techtalk/features/topic/data/models/topic_ref.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
  @override
  Future<List<TopicModel>> getTopics() async {
    final topicModels = await FirestoreTopicRef.collection().get();

    return [
      ...topicModels.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<List<TopicCategoryModel>> getTopicCategories() async {
    final topicCategoryModels =
        await FirestoreTopicCategoryRef.collection().get();

    return [
      ...topicCategoryModels.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<TopicQnaModel> getQna(
    String topicId,
    String questionId,
  ) async {
    final snapshot =
        await FirestoreTopicQuestionRef.doc(topicId, questionId).get();

    if (!snapshot.exists) {
      throw Exception();
    }

    return snapshot.data()!;
  }

  @override
  Future<List<TopicQnaModel>> getQnas(String topicId) async {
    final snapshot = await FirestoreTopicQuestionRef.collection(topicId).get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }
}
