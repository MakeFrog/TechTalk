import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';
import 'package:techtalk/features/interview/data/models/interview_qna_model.dart';

abstract interface class InterviewRepository {
  List<InterviewTopic> getTopics();

  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });
}
