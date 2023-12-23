import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class GetWrongAnswerNoteUseCase {
  GetWrongAnswerNoteUseCase(
    this.wrongAnswerNoteRepository,
  );

  final WrongAnswerNoteRepository wrongAnswerNoteRepository;

  Future<Result<List<WrongAnswerNoteEntity>>> call(String topicId) async {
    return wrongAnswerNoteRepository.getWrongAnswerNotes(topicId);
  }
}
