import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source_impl.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/job/repositories/job_repository_impl.dart';
import 'package:techtalk/features/job/usecases/get_job_group_list_use_case.dart';

final class JobDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<JobRemoteDataSource>(
      JobRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(
        jobRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator.registerFactory<GetJobGroupListUseCase>(
      () => GetJobGroupListUseCase(
        jobRepository,
      ),
    );
  }
}
