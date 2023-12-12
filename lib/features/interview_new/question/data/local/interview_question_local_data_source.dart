import 'dart:async';

import 'package:techtalk/features/interview_new/question/data/models/interview_answer_model.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_question_model.dart';

abstract interface class InterviewQuestionLocalDataSource {
  FutureOr<DateTime?> getUpdateDate(String topicId);
  FutureOr<List<InterviewQuestionModel>?> getQuestions(String topicId);
  FutureOr<InterviewQuestionModel?> getQuestion(
    String topicId,
    String questionId,
  );
  FutureOr<List<InterviewAnswerModel>?> getAnswers(
    String topicId,
    String questionId,
  );
}
