import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/data/local/interview_topic_local_data_source.dart';
import 'package:techtalk/features/topic/topic.dart';

class InterviewTopicRepositoryImpl implements TopicRepository {
  const InterviewTopicRepositoryImpl({
    required InterviewTopicLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;
  final InterviewTopicLocalDataSource _localDataSource;

  @override
  Result<List<Topic>> getTopics() {
    return Result.success(Topic.values);
  }

  @override
  Result<List<Topic>> searchTopics(String keyword) {
    return Result.success(
      [
        ...Topic.values.where(
          (e) => e.text.toLowerCase().startsWith(
                keyword.toLowerCase(),
              ),
        ),
      ],
    );
  }
}
