import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/topic/data/models/topic_question_model.dart';
import 'package:techtalk/features/topic/data/remote/topic_remote_data_source.dart';

final class TopicRemoteDataSourceImpl implements TopicRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<TopicQuestionModel> getQuestion(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await _firestore
        .collection('interview')
        .doc(topicId)
        .collection('questions')
        .doc(questionId)
        .get();

    if (!snapshot.exists) {
      throw Exception();
    }

    return TopicQuestionModel.fromFirestore(snapshot);
  }

  @override
  Future<List<TopicQuestionModel>> getQuestions(String topicId) async {
    final snapshot = await _firestore
        .collection('interview')
        .doc(topicId)
        .collection('questions')
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    final questions =
        snapshot.docs.map(TopicQuestionModel.fromFirestore).toList();

    return questions;
  }

  @override
  Future<DateTime> getUpdateDate(String topicId) async {
    final snapshot =
        await _firestore.collection('interview').doc(topicId).get();

    if (!snapshot.exists) {
      throw Exception();
    }

    final updateDate = snapshot.get('update_date') as Timestamp;

    return updateDate.toDate();
  }
}
