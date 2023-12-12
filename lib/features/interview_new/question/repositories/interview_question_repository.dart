import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/question/interview_question.dart';

abstract interface class InterviewQuestionRepository {
  FutureOr<Result<List<InterviewQuestionEntity>>> getQuestions(String topicId);

  FutureOr<Result<InterviewQuestionEntity>> getQuestion(
    String topicId,
    String questionId,
  );

  FutureOr<Result<List<InterviewAnswerEntity>>> getAnswers(
    String topicId,
    String questionId,
  );
}
