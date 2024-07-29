import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/data_source/local/boxes/system_local_data_source_impl.dart';
import 'package:techtalk/features/system/data_source/local/system_local_data_source.dart';
import 'package:techtalk/features/system/system.dart';

final class SystemDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<SystemRemoteDataSource>(
      SystemRemoteDataSourceImpl.new,
    );
    locator.registerLazySingleton<SystemLocalDataSource>(
      () => SystemLocalDataSourceImpl(AppLocal.systemBox),
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<SystemRepository>(
      () => SystemRepositoryImpl(systemRemoteDataSource, systemLocalDataSource),
    );
  }

  @override
  void useCases() {
    locator
      ..registerLazySingleton(
        () => GetVersionInfoUseCase(systemRepository),
      )
      ..registerLazySingleton(
        () => SetEntryFlowUseCase(systemRepository),
      );
  }
}
