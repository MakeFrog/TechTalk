import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/data/models/qna_model.dart';

abstract interface class InterviewLocalDataSource {
  /// 면접 주제 문답 리스트 호출
  Future<List<QnaModel>?> getCachedQnaList(String topicId);

  /// 면접 주제의 마지막 업데이트된 날짜 호출
  Future<DateTime?> getLastUpdatedDateByTopic(String topicId);

  Future<DateTime?> getCachedInterviewQuestionsUpdateDate(String topicId);

  Future<List<InterviewQuestionModel>?> getCachedQnaListOfTopic(String topicId);
}
