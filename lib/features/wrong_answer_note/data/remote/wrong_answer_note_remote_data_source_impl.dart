import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/topic/data/models/topic_question_model.dart';
import 'package:techtalk/features/wrong_answer_note/data/models/wrong_answer_qna_model.dart';
import 'package:techtalk/features/wrong_answer_note/data/remote/wrong_answer_note_remote_data_source.dart';

final class WrongAnswerNoteRemoteDataSourceImpl
    implements WrongAnswerNoteRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<TopicQuestionModel>> getQuestions({
    required String userUid,
    required String topicId,
  }) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.usersWrongAnswers.name)
        .doc(topicId)
        .collection(FirestoreCollection.usersWrongAnswersQna.name)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    final data = snapshot.docs
        .map(WrongAnswerQnAModel.fromFirestore)
        .map((e) => e.questionId)
        .toSet();
    final topicQuestionsCollection =
        FirestoreCollections.topics.question(topicId);

    final questions = data.map(
      (e) async => (await topicQuestionsCollection
              .doc(e)
              .withConverter(
                fromFirestore: TopicQuestionModel.fromFirestore,
                toFirestore: (value, options) => value.toJson(),
              )
              .get())
          .data()!,
    );

    return Future.wait(questions);
  }
}
