import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/interview/data/models/interview_qna_model.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/interview.dart';

final class InterviewRemoteDataSourceImpl implements InterviewRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<InterviewQnaModel>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  }) async {
    final reviewNoteCollection =
        _firestore.collection(FirestoreCollection.reviewNotes.name);
    final docSnapshot = await reviewNoteCollection.doc(userUid).get();

    print(reviewNoteCollection.doc(userUid));

    if (!docSnapshot.exists) {
      throw NoQnAsException('topicId');
    }
    final data = docSnapshot.get(topicId) as List;

    final questions = data
        .map(
          (e) => InterviewQnaModel(
            id: e['id'] as String,
            question: e['question'] as String,
            answers: (e['answers'] as List).map((e) => e as String).toList(),
            myAnswer: e['my_answer'] as String,
          ),
        )
        .toList();

    return questions;
  }

  @override
  Future<List<InterviewQuestionModel>> getInterviewQuestions(
    String topicId,
  ) async {
    final snapshot = await _firestore
        .collection('interview')
        .doc(topicId)
        .collection('questions')
        .get();

    if (snapshot.docs.isEmpty) {
      throw NoInterviewQuestionException('topicId');
    }

    final questions =
        snapshot.docs.map(InterviewQuestionModel.fromFirestore).toList();

    return questions;
  }

  @override
  Future<DateTime> getInterviewQuestionsUpdateDate(String topicId) async {
    final topicSnapshot =
        await _firestore.collection('interview').doc(topicId).get();
    final updateDate = topicSnapshot.get('update_date') as Timestamp;

    return updateDate.toDate();
  }
}