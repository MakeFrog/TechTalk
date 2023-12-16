import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

class WrongAnswerNoteRepositoryImpl implements WrongAnswerNoteRepository {
  const WrongAnswerNoteRepositoryImpl();
  @override
  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  }) async {
    try {
      throw Exception();

      // final questionsModel =
      //     await _interviewRemoteDataSource.getReviewNoteQuestions(
      //   userUid: userUid,
      //   topicId: topicId,
      // );
      //
      // final questionsEntity = questionsModel.map((e) {
      //   return InterviewQnAEntity(
      //     id: e.id,
      //     question: e.question,
      //     idealAnswer: e.answers,
      //     response: UserInterviewResponse(
      //       e.myAnswer,
      //       state: AnswerState.wrong,
      //     ),
      //   );
      // }).toList();
      //
      // return Result.success(questionsEntity);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
