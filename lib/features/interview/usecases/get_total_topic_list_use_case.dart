import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetTotalTopicListUseCase
    extends BaseNoParamUseCase<Result<List<TopicEntity>>> {
  GetTotalTopicListUseCase(this._repository);

  final InterviewRepository _repository;

  @override
  Future<Result<List<TopicEntity>>> call() async => _repository.getTopics();
}
