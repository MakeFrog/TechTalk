import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class GetJobsUseCase {
  GetJobsUseCase(
    this._jobRepository,
  );

  final TechSetRepository _jobRepository;

  List<JobGroup> call() {
    return _jobRepository.getJobs();
  }
}
