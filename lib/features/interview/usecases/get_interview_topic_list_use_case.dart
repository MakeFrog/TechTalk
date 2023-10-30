import 'package:techtalk/features/interview/interview.dart';

final class GetInterviewTopicListUseCase {
  const GetInterviewTopicListUseCase(
    this._interviewRepository,
  );

  final InterviewRepository _interviewRepository;

  Future<List<InterviewTopicEntity>> call() async {
    return _interviewRepository.getInterviewTopicList();
  }
}
