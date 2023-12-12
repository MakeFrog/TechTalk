import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetInterviewQuestionsUseCase {
  const GetInterviewQuestionsUseCase(
    this._interviewRepository,
  );

  final InterviewRepository _interviewRepository;

  Future<List<InterviewQuestionEntity>> call(String topicId) async {
    final questions = await _interviewRepository.getInterviewQuestions(topicId);

    return questions.fold(
      onSuccess: (value) => value,
      onFailure: (e) {
        throw e;
      },
    );
  }
}
