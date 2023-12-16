import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/entities/interview_question_entity.dart';
import 'package:techtalk/features/interview_new/repositories/interview_repository.dart';

final class GetInterviewQuestionsUseCase {
  const GetInterviewQuestionsUseCase(
    this._interviewRepository,
  );

  final InterviewRepository _interviewRepository;

  Future<Result<List<InterviewQuestionEntity>>> call(String topicId) async {
    return _interviewRepository.getQuestionsOfTopic(topicId);
  }
}
