import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

abstract interface class WrongAnswerNoteRepository {
  Future<Result<List<WrongAnswerQuestionEntity>>> getQuestions(String topicId);

  Future<Result<WrongAnswerQnAEntity>> getQnA(
    String topicId,
    String questionId,
  );
}
