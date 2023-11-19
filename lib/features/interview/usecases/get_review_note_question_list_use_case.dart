import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetReviewNoteQuestionListUseCase {
  const GetReviewNoteQuestionListUseCase(this._interviewRepository);

  final InterviewRepository _interviewRepository;

  Future<Result<List<InterviewQnAEntity>>> call({
    required String userUid,
    required String topicId,
  }) async {
    return _interviewRepository.getReviewNoteQuestions(
      userUid: userUid,
      topicId: topicId,
    );
  }
}
