import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/auth/auth.dart';
import 'package:techtalk/features/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:techtalk/features/auth/repositories/auth_repository_impl.dart';

final class AuthDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => SignInOAuthUseCase(
          authRepository,
        ),
      )
      ..registerFactory(
        () => SignOutUseCase(
          authRepository,
        ),
      );
  }
}
