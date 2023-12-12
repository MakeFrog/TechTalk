import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview_new/question/interview_question.dart';
import 'package:techtalk/features/interview_new/question/repositories/interview_question_repository.dart';

final class GetInterviewQuestionsUseCase {
  const GetInterviewQuestionsUseCase(
    this._interviewRepository,
  );

  final InterviewQuestionRepository _interviewRepository;

  FutureOr<Result<List<InterviewQuestionEntity>>> call(
    String topicId,
  ) async {
    return Result.success(
      List.generate(
        50,
        (index) => InterviewQuestionEntity(
          id: 'id$index',
          question: 'question $index',
          answers: ['answers $index'],
        ),
      ),
    );

    return _interviewRepository.getQuestions(topicId);
  }
}
