import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source.dart';
import 'package:techtalk/features/job/repositories/job_repository.dart';
import 'package:techtalk/features/job/usecases/get_job_group_list_use_case.dart';

export 'data/remote/job_remote_data_source.dart';
export 'models/job_group_model.dart';
export 'models/job_model.dart';
export 'repositories/job_repository.dart';
export 'usecases/get_job_group_list_use_case.dart';

final jobRemoteDataSource = locator<JobRemoteDataSource>();
final jobRepository = locator<JobRepository>();
final getJobGroupListUseCase = locator<GetJobGroupListUseCase>();
