import 'package:techtalk/features/wrong_answer_note/data/models/wrong_answer_note_model.dart';

abstract interface class WrongAnswerNoteRemoteDataSource {
  Future<List<WrongAnswerNoteModel>> getWrongAnswerNotes(String topicId);
  Future<DateTime> getLastUpdateDate(String questionId);
}
