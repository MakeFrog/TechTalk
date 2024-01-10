import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class GetJobsUseCase {
  GetJobsUseCase(
    this._jobRepository,
  );

  final JobRepository _jobRepository;

  Result<List<JobEntity>> call() {
    return _jobRepository.getJobs();
  }
}
