import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class WrongAnswerNoteRemoteDataSourceImpl
    implements WrongAnswerNoteRemoteDataSource {
  @override
  Future<List<WrongAnswerNoteModel>> getWrongAnswerNotes(String topicId) async {
    final snapshot = await FirestoreWrongAnswerNoteRef.collection().get();

    if (snapshot.docs.isEmpty) {
      throw Exception('오답노트가 비어있습니다.');
    }

    final notes = [
      ...snapshot.docs
          .where(
            (element) => element.id.contains(topicId),
          )
          .map((e) => e.data()),
    ];

    return notes;
  }

  @override
  Future<DateTime> getLastUpdateDate(String questionId) async {
    final snapshot = await FirestoreWrongAnswerNoteRef.doc(questionId).get();

    return snapshot.data()!.updatedAt;
  }
}
