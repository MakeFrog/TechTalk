import 'package:techtalk/features/interview/interview.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  const InterviewRepositoryImpl(
    this._interviewLocalDataSource,
  );
  final InterviewLocalDataSource _interviewLocalDataSource;

  @override
  Future<List<InterviewTopicEntity>> getInterviewTopicList() async {
    final model = _interviewLocalDataSource.getInterviewTopicList();
    final topicList = model.map(InterviewTopicEntity.fromModel).toList();

    return topicList;
  }
}
