import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/tech_set/data/local/tech_set_data_source_impl.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository_impl.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/tech_set/usecases/get_searched_skills.dart';

final class JobDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<TechSetLocalDataSource>(
        TechSetLocalDataSourceImpl.new,
      );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<TechSetRepository>(
      () => TechSetRepositoryImpl(
        techSetLocalDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory<GetJobsUseCase>(() => GetJobsUseCase(
            techSetRepository,
          ))
      ..registerFactory(() => GetSearchedSkills(techSetRepository));
  }
}
