import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/job.dart';

final class GetJobGroupsUseCase {
  const GetJobGroupsUseCase(
    this._jobRepository,
  );

  final JobRepository _jobRepository;

  Future<Result<JobGroupListEntity>> call() async {
    return _jobRepository.getJobGroups();
  }
}
