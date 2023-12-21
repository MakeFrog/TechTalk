import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

part 'wrong_answer_questions_provider.g.dart';

@Riverpod(keepAlive: true)
class WrongAnswerQuestions extends _$WrongAnswerQuestions {
  @override
  FutureOr<List<TopicQuestionEntity>> build(String topicId) async {
    final questions = await getWrongAnswerNoteQuestionsUseCase(topicId);

    return questions.getOrThrow();
  }
}
