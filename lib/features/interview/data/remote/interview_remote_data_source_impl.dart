import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/models/custom_exception.dart';
import 'package:techtalk/features/interview/data/models/interview_qna_model.dart';
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
      throw CustomException(code: 'code', message: '오답노트 데이터 없음');
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
}