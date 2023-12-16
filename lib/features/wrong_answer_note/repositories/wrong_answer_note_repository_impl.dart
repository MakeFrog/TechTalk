import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

class WrongAnswerNoteRepositoryImpl implements WrongAnswerNoteRepository {
  const WrongAnswerNoteRepositoryImpl({
    required this.remoteDataSource,
  });

  final WrongAnswerNoteRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<WrongAnswerQuestionEntity>>> getQuestions(
    String topicId,
  ) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final questionsModel = await remoteDataSource.getQuestions(
        userUid: userUid,
        topicId: topicId,
      );

      return Result.success(
        [
          ...questionsModel.map(
            (e) => WrongAnswerQuestionEntity(
              id: e.id,
              question: e.question,
            ),
          ),
        ],
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<WrongAnswerQnAEntity>> getQnA(
    String topicId,
    String questionId,
  ) async {
    // TODO: implement getQnA
    throw UnimplementedError();
  }
}
