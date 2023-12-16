import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class GetWrongAnswerNoteQuestionsUseCase {
  GetWrongAnswerNoteQuestionsUseCase(
    this.wrongAnswerNoteRepository,
  );

  final WrongAnswerNoteRepository wrongAnswerNoteRepository;

  Future<Result<List<WrongAnswerQuestionEntity>>> call(String topicId) async {
    return wrongAnswerNoteRepository.getQuestions(topicId);
  }
}
