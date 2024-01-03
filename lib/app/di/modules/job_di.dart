import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/job/repositories/job_repository_impl.dart';

final class JobDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {}

  @override
  void repositories() {
    locator.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(),
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
