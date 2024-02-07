import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/wrong_answer_note/repositories/entities/wrong_answer_note_entity.dart';

abstract interface class WrongAnswerNoteRepository {
  Future<Result<List<WrongAnswerNoteEntity>>> getWrongAnswerNotes(
      String topicId);
}
