import 'package:techtalk/features/interview/data/models/interview_qna_model.dart';

abstract interface class InterviewRemoteDataSource {
  Future<List<InterviewQnaModel>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });
}
