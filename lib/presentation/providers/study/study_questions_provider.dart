import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

part 'study_questions_provider.g.dart';

@riverpod
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<InterviewQuestionEntity>> build(String topicId) async {
    final result = await interviewRepository.getInterviewQuestions(topicId);

    return result.getOrThrow();
  }
}
