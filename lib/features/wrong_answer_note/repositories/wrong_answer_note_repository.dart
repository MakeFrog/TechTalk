import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

abstract interface class WrongAnswerNoteRepository {
  Future<Result<List<TopicQuestionEntity>>> getQuestions(String topicId);

  Future<Result<({WrongAnswerQnAEntity qna, List<String> wrongAnswers})>>
      getQnA(
    String topicId,
    String questionId,
  );
}
