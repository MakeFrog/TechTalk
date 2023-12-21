import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class WrongAnswerNoteRemoteDataSourceImpl
    implements WrongAnswerNoteRemoteDataSource {
  @override
  Future<List<WrongAnswerQnAModel>> getQnas({
    required String userUid,
    required String topicId,
  }) async {
    final snapshot = await FirestoreWrongAnswerRef.collection()
        .withConverter(
          fromFirestore: WrongAnswerQnAModel.fromFirestore,
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception();
    }

    final data = snapshot.docs.where((element) => element.id.contains(topicId));

    return [
      ...data.map((e) => e.data()),
    ];

    // final questions = data.map(
    //   (e) async => FirestoreTopicQuestionRef.doc(topicId, e.id)
    //       .withConverter(
    //         fromFirestore: TopicQuestionModel.fromFirestore,
    //         toFirestore: (value, options) => value.toJson(),
    //       )
    //       .get()
    //       .then((value) => value.data()!),
    // );
    //
    // return Future.wait(questions);
  }
}
