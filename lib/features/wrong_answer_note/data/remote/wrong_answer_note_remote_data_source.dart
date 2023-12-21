import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

abstract interface class WrongAnswerNoteRemoteDataSource {
  Future<List<WrongAnswerQnAModel>> getQuestions({
    required String userUid,
    required String topicId,
  });
}
