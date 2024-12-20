import 'package:dio/dio.dart';
import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/network/app_dio.dart';
import 'package:techtalk/core/modules/local/app_local.dart';
import 'package:techtalk/features/tech_set/data_source/local/tech_set_data_source_impl.dart';
import 'package:techtalk/features/tech_set/data_source/remote/tech_set_remote_data_source.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository_impl.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/tech_set/usecases/get_searched_skill_sets_use_case.dart';
import 'package:techtalk/features/tech_set/usecases/get_searched_skills.dart';

final class TechSetDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<TechSetLocalDataSource>(
        () => TechSetLocalDataSourceImpl(AppLocal.techSetBox),
      )
      ..registerLazySingleton<TechSetRemoteDataSource>(
          () => TechSetRemoteDataSource(AppDio.getInstance()));
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
      ..registerFactory(() => GetSearchedSkills(techSetRepository))
      ..registerLazySingleton(GetSearchedSkillSetUseCase.new);
  }
}
