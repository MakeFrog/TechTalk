import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

class WrongAnswerNoteRepositoryImpl implements WrongAnswerNoteRepository {
  const WrongAnswerNoteRepositoryImpl({
    required this.remoteDataSource,
  });

  final WrongAnswerNoteRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<TopicQuestionEntity>>> getQuestions(
    String topicId,
  ) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final questionsModel = await remoteDataSource.getQnas(
        userUid: userUid,
        topicId: topicId,
      );
      final questions = questionsModel.map(
        (e) => topicRepository
            .getTopicQuestion(topicId, e.questionId)
            .then((value) => value.getOrThrow()),
      );
      return Result.success(
        await Future.wait(questions),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<({WrongAnswerQnAEntity qna, List<String> wrongAnswers})>>
      getQnA(
    String topicId,
    String questionId,
  ) async {
    // TODO: implement getQnA
    throw UnimplementedError();
  }
}
