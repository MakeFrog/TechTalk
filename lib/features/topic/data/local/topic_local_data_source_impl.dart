import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/topic/data/local/topic_local_data_source.dart';
import 'package:techtalk/features/topic/data/models/topic_question_model.dart';

class TopicLocalDataSourceImpl implements TopicLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<TopicQuestionModel>?> getQuestions(
    String topicId,
  ) async {
    final snapshot = await _firestore
        .collection('interview')
        .doc(topicId)
        .collection('questions')
        .get(const GetOptions(source: Source.cache));

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return [
      ...snapshot.docs.map(TopicQuestionModel.fromFirestore),
    ];
  }

  @override
  Future<DateTime?> getUpdateDate(String topicId) async {
    try {
      final topicSnapshot = await _firestore
          .collection('interview')
          .doc(topicId)
          .get(const GetOptions(source: Source.cache));
      final updateDate = topicSnapshot.get('update_date') as Timestamp;

      return updateDate.toDate();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TopicQuestionModel?> getQuestion(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await _firestore
        .collection('interview')
        .doc(topicId)
        .collection('questions')
        .doc(questionId)
        .get(const GetOptions(source: Source.cache));

    if (!snapshot.exists) {
      return null;
    }

    return TopicQuestionModel.fromFirestore(snapshot);
  }
}
