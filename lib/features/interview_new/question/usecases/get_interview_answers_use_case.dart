import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/question/interview_question.dart';
import 'package:techtalk/features/interview_new/question/repositories/interview_question_repository.dart';

final class GetInterviewAnswersUseCase {
  const GetInterviewAnswersUseCase(
    this._interviewRepository,
  );

  final InterviewQuestionRepository _interviewRepository;

  FutureOr<Result<List<InterviewAnswerEntity>>> call(
    String topicId,
    String questionId,
  ) async {
    return _interviewRepository.getAnswers(
      topicId,
      questionId,
    );
  }
}
