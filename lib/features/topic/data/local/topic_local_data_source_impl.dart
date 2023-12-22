import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/topic/topic.dart';

class TopicLocalDataSourceImpl implements TopicLocalDataSource {
  @override
  Future<List<TopicQnaEntity>?> getQnas(
    String topicId,
  ) async {
    final snapshot = await FirestoreTopicQuestionRef.collection(topicId)
        .withConverter(
          fromFirestore: TopicQnaModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get(const GetOptions(source: Source.cache));

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return [
      ...snapshot.docs.map((e) => e.data().toEntity()),
    ];
  }

  @override
  Future<TopicQnaEntity?> getQna(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await FirestoreTopicQuestionRef.doc(topicId, questionId)
        .withConverter(
          fromFirestore: TopicQnaModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get(const GetOptions(source: Source.cache));

    if (!snapshot.exists) {
      return null;
    }

    return snapshot.data()!.toEntity();
  }
}
