import 'package:techtalk/features/interview/data/models/interview_qna_model.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview/data/models/qna_model.dart';
import 'package:techtalk/features/interview/data/models/topic_model.dart';

abstract interface class InterviewRemoteDataSource {
  /// 면접 주제 리스트 호출
  Future<List<TopicModel>> getTopics();

  /// 면접 주제 정보 호출
  Future<TopicModel?> getTopicById(String id);

  /// 면접 주제 문답 리스트 호출
  Future<List<QnaModel>> getQnaList(String topicId);

  Future<List<InterviewQnaModel>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });

  Future<DateTime> getInterviewQuestionsUpdateDate(String topicId);

  Future<List<InterviewQuestionModel>> getQnaListOfTopic(String topicId);
}
