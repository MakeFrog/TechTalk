import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/job/entities/job_group_list_entity.dart';
import 'package:techtalk/features/job/job.dart';

final class GetJobGroupListUseCase {
  const GetJobGroupListUseCase(
    this._jobRepository,
  );

  final JobRepository _jobRepository;

  Future<Result<JobGroupListEntity>> call() async {
    return _jobRepository.getJobGroupList();
  }
}
