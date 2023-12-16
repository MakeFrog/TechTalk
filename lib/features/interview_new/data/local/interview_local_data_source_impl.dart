import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/interview_new/data/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview_new/data/models/interview_question_model.dart';

class InterviewLocalDataSourceImpl implements InterviewLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<InterviewQuestionModel>?> getQuestionsOfTopic(
    String topicId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollection.interview.name)
          .doc(topicId)
          .collection(FirestoreCollection.interviewQuestions.name)
          .get(const GetOptions(source: Source.cache));

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return [
        ...snapshot.docs.map(
          InterviewQuestionModel.fromFirestore,
        ),
      ];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DateTime?> getUpdateDateOfTopic(String topicId) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollection.interview.name)
          .doc(topicId)
          .get(const GetOptions(source: Source.cache));
      final updateDate = snapshot.get('update_date') as Timestamp?;

      return updateDate?.toDate();
    } catch (e) {
      return null;
    }
  }
}
