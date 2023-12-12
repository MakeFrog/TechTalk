import 'package:techtalk/features/interview_new/question/data/models/interview_answer_model.dart';
import 'package:techtalk/features/interview_new/question/data/models/interview_question_model.dart';

abstract interface class InterviewQuestionRemoteDataSource {
  Future<DateTime> getUpdateDate(String topicId);
  Future<List<InterviewQuestionModel>> getQuestions(String topicId);
  Future<InterviewQuestionModel> getQuestion(
    String topicId,
    String questionId,
  );
  Future<List<InterviewAnswerModel>> getAnswers(
    String topicId,
    String questionId,
  );
}
