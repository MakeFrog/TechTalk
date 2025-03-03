import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/core/modules/local/app_local.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source_impl.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/tech_set/usecases/get_searched_skills_use_case.dart';

final class TechSetDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<TechSetLocalDataSource>(
        () => TechSetLocalDataSourceImpl(AppLocal.techSetBox),
      )
      ..registerLazySingleton<TechSetRemoteDataSource>(
          () => TechSetRemoteDataSourceIml());
  }

  @override
  void repositories() {
    locator.registerLazySingleton<TechSetRepository>(
      () => TechSetRepositoryImpl(
        techSetLocalDataSource,
        techSetRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory<GetJobsUseCase>(() => GetJobsUseCase(
            techSetRepository,
          ))
      ..registerLazySingleton(() => GetSearchedSkillsUseCase());
  }
}
