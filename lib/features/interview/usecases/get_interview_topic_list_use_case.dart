import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';
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
