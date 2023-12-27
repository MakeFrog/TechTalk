import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/system/data/remote/system_remote_data_source.dart';
import 'package:techtalk/features/system/data/remote/system_remote_data_source_impl.dart';
import 'package:techtalk/features/system/repositories/system_repository.dart';
import 'package:techtalk/features/system/repositories/system_repository_impl.dart';
import 'package:techtalk/features/system/use_cases/get_version_info_use_case.dart';

final class SystemDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<SystemRemoteDataSource>(
        () => SystemRemoteDataSourceImpl());
  }

  @override
  void repositories() {
    locator.registerLazySingleton<SystemRepository>(
        () => SystemRepositoryImpl(locator<SystemRemoteDataSource>()));
  }

  @override
  void useCases() {
    locator.registerLazySingleton(
        () => GetVersionInfoUseCase(locator<SystemRepository>()));
  }
}
