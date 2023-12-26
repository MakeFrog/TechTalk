import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/data/local/job_local_data_source.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source.dart';
import 'package:techtalk/features/job/repositories/job_repository.dart';
import 'package:techtalk/features/job/usecases/get_jobs_use_case.dart';

export 'data/local/job_local_data_source.dart';
export 'data/remote/job_remote_data_source.dart';
export 'entities/job_entity.dart';
export 'repositories/job_repository.dart';
export 'usecases/get_jobs_use_case.dart';

final jobRemoteDataSource = locator<JobRemoteDataSource>();
final jobLocalDataSource = locator<JobLocalDataSource>();

final jobRepository = locator<JobRepository>();
final getJobsUseCase = locator<GetJobsUseCase>();
