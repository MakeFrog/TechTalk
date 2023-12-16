import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/topic/data/models/topic_question_model.dart';
import 'package:techtalk/features/wrong_answer_note/data/remote/wrong_answer_note_remote_data_source.dart';

final class WrongAnswerNoteRemoteDataSourceImpl
    implements WrongAnswerNoteRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<TopicQuestionModel>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  }) async {
    throw Exception();

    // final snapshot = await _firestore
    //     .collection(FirestoreCollection.users.name)
    //     .doc(userUid)
    //     .collection('wrong-answers')
    //     .doc(topicId)
    //     .get();
    //
    // if (!snapshot.exists) {
    //   throw Exception();
    // }
    //
    // final data = docSnapshot.get(topicId) as List;
    //
    // final questions = data
    //     .map(
    //       (e) => InterviewQnaModel(
    //         id: e['id'] as String,
    //         question: e['question'] as String,
    //         answers: (e['answers'] as List).map((e) => e as String).toList(),
    //         myAnswer: e['my_answer'] as String,
    //       ),
    //     )
    //     .toList();
    //
    // return questions;
  }
}
