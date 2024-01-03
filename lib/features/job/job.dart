import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/job/repositories/job_repository.dart';
import 'package:techtalk/features/job/usecases/get_jobs_use_case.dart';

export 'entities/job_entity.dart';
export 'repositories/job_repository.dart';
export 'usecases/get_jobs_use_case.dart';

final jobRepository = locator<JobRepository>();
final getJobsUseCase = locator<GetJobsUseCase>();
