import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/repositories/entities/interview_qna_entity.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class GetReviewNoteQuestionListUseCase {
  const GetReviewNoteQuestionListUseCase(this._interviewRepository);

  final WrongAnswerNoteRepository _interviewRepository;

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
