import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/job/data/local/job_local_data_source_impl.dart';
import 'package:techtalk/features/job/data/remote/job_remote_data_source_impl.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/job/repositories/job_repository_impl.dart';

final class JobDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<JobRemoteDataSource>(
        JobRemoteDataSourceImpl.new,
      )
      ..registerLazySingleton<JobLocalDataSource>(
        JobLocalDataSourceImpl.new,
      );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(
        jobRemoteDataSource,
        jobLocalDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator.registerFactory<GetJobsUseCase>(
      () => GetJobsUseCase(
        jobRepository,
      ),
    );
  }
}
