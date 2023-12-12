import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/data/local/job_local_data_source.dart';
import 'package:techtalk/features/job/repositories/job_repository.dart';
import 'package:techtalk/features/job/usecases/get_job_groups_use_case.dart';

export 'entities/job_group_entity.dart';
export 'entities/job_group_list_entity.dart';
export 'repositories/job_repository.dart';
export 'usecases/get_job_groups_use_case.dart';

final jobLocalDataSource = locator<JobLocalDataSource>();
final jobRepository = locator<JobRepository>();
final getJobGroupsUseCase = locator<GetJobGroupsUseCase>();
