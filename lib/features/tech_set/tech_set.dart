import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/tech_set/usecases/get_searched_skills_use_case.dart';

export 'data_source/local/tech_set_data_source_impl.dart';
export 'data_source/local/tech_set_local_data_source.dart';
export 'repositories/enums/job.enum.dart';
export 'repositories/tech_set_repository.dart';
export 'repositories/tech_set_repository_impl.dart';
export 'tech_set.dart';
export 'usecases/get_jobs_use_case.dart';

final techSetLocalDataSource = locator<TechSetLocalDataSource>();
final techSetRemoteDataSource = locator<TechSetRemoteDataSource>();
final techSetRepository = locator<TechSetRepository>();
final getJobsUseCase = locator<GetJobsUseCase>();
final getSearchedSkillSetUseCase = locator<GetSearchedSkillsUseCase>();
