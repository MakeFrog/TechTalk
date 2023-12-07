import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetInterviewQuestionsUseCase {
  const GetInterviewQuestionsUseCase(
    this._interviewRepository,
  );

  final InterviewRepository _interviewRepository;

  Future<Result<List<InterviewQuestionEntity>>> call(String topicId) async {
    return _interviewRepository.getInterviewQuestions(topicId);
  }
}
