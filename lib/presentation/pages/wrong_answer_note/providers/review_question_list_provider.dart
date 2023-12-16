import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/interview_qna_entity.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_review_note_topic_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'review_question_list_provider.g.dart';

@riverpod
class ReviewQuestionList extends _$ReviewQuestionList {
  @override
  FutureOr<List<InterviewQnAEntity>> build() async {
    final selectedTopic =
        await ref.watch(selectedReviewNoteTopicProvider.future);
    final userData = await ref.watch(userDataProvider.future);

    final questions = await getReviewNoteQuestionListUseCase(
      userUid: userData!.uid,
      topicId: selectedTopic.id,
    );

    return questions.getOrThrow();
  }
}
