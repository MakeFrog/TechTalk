import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/tech_set/data/local/tech_set_data_source_impl.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository_impl.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

import '../../../features/tech_set/data/remote/tech_set_data_source_impl.dart';

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
