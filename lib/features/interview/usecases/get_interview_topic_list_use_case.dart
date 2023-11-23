import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetInterviewTopicListUseCase {
  const GetInterviewTopicListUseCase(
    this._interviewRepository,
  );

  final InterviewRepository _interviewRepository;

  Future<List<InterviewTopic>> call() async {
    return _interviewRepository.getTopics();
  }
}
