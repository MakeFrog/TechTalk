import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class GetJobsUseCase {
  GetJobsUseCase(
    this._jobRepository,
  );

  final TechSetRepository _jobRepository;

  List<JobGroupEntity> call() {
    return _jobRepository.getJobs();
  }
}
