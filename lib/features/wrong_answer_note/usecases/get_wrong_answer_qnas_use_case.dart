import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

final class GetWrongAnswerQnAUseCase {
  const GetWrongAnswerQnAUseCase(this._wrongAnswerNoteRepository);

  final WrongAnswerNoteRepository _wrongAnswerNoteRepository;

  Future<Result<List<WrongAnswerQnAEntity>>> call({
    required String userUid,
    required String topicId,
  }) async {
    return Result.success([]);
    // return _interviewRepository.getQuestions(
    //   userUid: userUid,
    //   topicId: topicId,
    // );
  }
}
