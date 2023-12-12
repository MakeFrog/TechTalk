import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/question/interview_question.dart';
import 'package:techtalk/features/interview_new/question/repositories/interview_question_repository.dart';

final class GetInterviewQuestionUseCase {
  const GetInterviewQuestionUseCase(
    this._interviewRepository,
  );

  final InterviewQuestionRepository _interviewRepository;

  FutureOr<Result<InterviewQuestionEntity>> call(
    String topicId,
    String questionId,
  ) async {
    return _interviewRepository.getQuestion(
      topicId,
      questionId,
    );
  }
}
