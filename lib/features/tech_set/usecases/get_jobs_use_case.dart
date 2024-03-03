import 'package:techtalk/features/tech_set/repositories/enums/job.enum.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class GetJobsUseCase {
  GetJobsUseCase(
    this._jobRepository,
  );

  final TechSetRepository _jobRepository;

  List<Job> call() {
    return _jobRepository.getJobs();
  }
}
