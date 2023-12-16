import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';
import 'package:techtalk/presentation/providers/wrong_answer/selected_wrong_answer_topic_provider.dart';

part 'wrong_answer_questions_provider.g.dart';

@riverpod
class WrongAnswerQuestions extends _$WrongAnswerQuestions {
  @override
  FutureOr<List<WrongAnswerQuestionEntity>> build() async {
    final topic = ref.watch(selectedWrongAnswerTopicProvider);

    final questions = await getWrongAnswerNoteQuestionsUseCase(topic.id);

    return questions.getOrThrow();
  }
}
