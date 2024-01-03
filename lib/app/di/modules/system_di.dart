import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/system/system.dart';

final class SystemDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<SystemRemoteDataSource>(
      SystemRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<SystemRepository>(
      () => SystemRepositoryImpl(systemRemoteDataSource),
    );
  }

  @override
  void useCases() {
    locator.registerLazySingleton(
      () => GetVersionInfoUseCase(systemRepository),
    );
  }
}
