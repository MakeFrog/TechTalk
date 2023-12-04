import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetInterviewTopicsUseCase {
  const GetInterviewTopicsUseCase(
    this._interviewRepository,
  );

  final InterviewRepository _interviewRepository;

  Future<List<InterviewTopic>> call() async {
    return _interviewRepository.getTopics();
  }
}
