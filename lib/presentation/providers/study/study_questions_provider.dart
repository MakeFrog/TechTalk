import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';

part 'study_questions_provider.g.dart';

@Riverpod(
  dependencies: [
    selectedStudyTopicId,
  ],
)
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<InterviewQuestionEntity>> build() async {
    final topicId = ref.watch(selectedStudyTopicIdProvider);

    final result = await interviewRepository.getInterviewQuestions(topicId);

    return result.getOrThrow();
  }

  void updateTest() {
    state = AsyncData([...state.requireValue, ...state.requireValue]);
  }
}
