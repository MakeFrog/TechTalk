import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/interview.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<InterviewQuestionModel>?> getCachedInterviewQuestions(
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
}
