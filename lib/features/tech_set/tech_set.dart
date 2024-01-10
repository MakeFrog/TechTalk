import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

export 'data/local/tech_set_local_data_source.dart';
export 'data/remote/tech_set_data_source.dart';
export 'entities/job_entity.dart';
export 'repositories/tech_set_repository.dart';
export 'usecases/get_jobs_use_case.dart';

final jobRemoteDataSource = locator<JobRemoteDataSource>();
final jobLocalDataSource = locator<JobLocalDataSource>();

final jobRepository = locator<JobRepository>();
final getJobsUseCase = locator<GetJobsUseCase>();
