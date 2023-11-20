import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

abstract interface class InterviewRepository {
  List<InterviewTopic> getTopics();

  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });
}
