import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/topic/data/models/topic_question_model.dart';
import 'package:techtalk/features/wrong_answer_note/data/remote/wrong_answer_note_remote_data_source.dart';

final class WrongAnswerNoteRemoteDataSourceImpl
    implements WrongAnswerNoteRemoteDataSource {
  @override
  Future<List<TopicQuestionModel>> getQuestions({
    required String userUid,
    required String topicId,
  }) async {
    final snapshot =
        await FirestoreCollections.users.wrongAnswer().collection().get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    final data = snapshot.docs
        .where((element) => element.id.contains(topicId))
        .map((e) => e.id);

    final questions = data.map(
      (e) async => (await FirestoreCollections.topics
              .question(topicId)
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
