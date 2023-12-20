import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicLocalDataSourceImpl implements TopicLocalDataSource {
  @override
  Future<List<TopicQuestionModel>?> getQuestions(
    String topicId,
  ) async {
    final snapshot = await FirestoreCollections.topics
        .question(topicId)
        .collection()
        .withConverter(
          fromFirestore: TopicQuestionModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get(const GetOptions(source: Source.cache));

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<DateTime?> getUpdateDate(String topicId) async {
    try {
      final topicSnapshot = await FirestoreCollections.topics
          .doc(topicId)
          .withConverter(
            fromFirestore: TopicModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          )
          .get(const GetOptions(source: Source.cache));

      return topicSnapshot.data()?.updatedAt;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TopicQuestionModel?> getQuestion(
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
        .get(const GetOptions(source: Source.cache));

    if (!snapshot.exists) {
      return null;
    }

    return snapshot.data();
  }
}
