import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/data/models/qna_model.dart';
import 'package:techtalk/features/interview/data/models/topic_model.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<InterviewQuestionModel>?> getCachedQnaListOfTopic(
    String topicId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('interview')
          .doc(topicId)
          .collection('questions')
          .get(
            const GetOptions(
              source: Source.cache,
            ),
          );

      if (snapshot.docs.isEmpty) {
        return null;
      }

      final questions =
          snapshot.docs.map(InterviewQuestionModel.fromFirestore).toList();

      return questions;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DateTime?> getCachedInterviewQuestionsUpdateDate(
    String topicId,
  ) async {
    try {
      final topicSnapshot = await _firestore
          .collection('interview')
          .doc(topicId)
          .get(const GetOptions(source: Source.cache));
      final updateDate = topicSnapshot.get('update_date') as Timestamp?;

      return updateDate?.toDate();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<QnaModel>?> getCachedQnaList(String topicId) async {
    try {
      final qnaListSnapshot = await _firestore
          .collection(FirestoreCollection.topics.name)
          .doc(topicId)
          .collection(FirestoreCollection.qna.name)
          .withConverter(
            fromFirestore: QnaModel.fromFirestore,
            toFirestore: (model, _) => model.toJson(),
          )
          .get(
            const GetOptions(
              source: Source.cache,
            ),
          );

      if (qnaListSnapshot.docs.isEmpty) return null;

      final response = qnaListSnapshot.docs.map((e) => e.data()).toList();
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DateTime?> getLastUpdatedDateByTopic(String topicId) async {
    final topicSnapshot = await _firestore
        .collection(FirestoreCollection.topics.name)
        .withConverter(
            fromFirestore: TopicModel.fromFirestore,
            toFirestore: (model, _) => model.toJson())
        .doc(topicId)
        .get(
          const GetOptions(
            source: Source.cache,
          ),
        );

    final response = topicSnapshot.data();

    return response?.lastUpdatedDate;
  }
}
