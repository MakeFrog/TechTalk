import 'package:techtalk/features/topic/data/models/topic_question_model.dart';

abstract interface class WrongAnswerNoteRemoteDataSource {
  Future<List<TopicQuestionModel>> getQuestions({
    required String userUid,
    required String topicId,
  });
}
