import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/providers/wrong_answer/selected_wrong_answer_topic_provider.dart';

part 'wrong_answer_questions_provider.g.dart';

@riverpod
class WrongAnswerQuestions extends _$WrongAnswerQuestions {
  @override
  FutureOr<List<InterviewQnAEntity>> build() async {
    final topic = ref.watch(selectedWrongAnswerTopicProvider);
    final userData = await ref.watch(userDataProvider.future);

    return [];
    // final questions = await getWrongAnswerQnAsUseCase(
    //   userUid: userData!.uid,
    //   topicId: topic.id,
    // );
    //
    // return questions.getOrThrow();
  }
}
