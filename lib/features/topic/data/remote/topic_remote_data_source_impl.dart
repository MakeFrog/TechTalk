import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
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

  @override
  Future<DateTime> getUpdateDate(String topicId) async {
    final snapshot = await FirestoreCollections.topics
        .doc(topicId)
        .withConverter(
          fromFirestore: TopicModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (!snapshot.exists) {
      throw Exception();
    }

    return snapshot.data()!.updatedAt!;
  }
}
