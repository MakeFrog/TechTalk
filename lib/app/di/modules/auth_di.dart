import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/auth/auth.dart';
import 'package:techtalk/features/auth/data/remote/auth_remote_data_source_impl.dart';
import 'package:techtalk/features/auth/repositories/auth_repository_impl.dart';

final class AuthDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I.registerLazySingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    GetIt.I.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    GetIt.I
      ..registerFactory<SignInOAuthUseCase>(
        () => SignInOAuthUseCase(
          authRepository,
        ),
      )
      ..registerFactory<SignOutUseCase>(
        () => SignOutUseCase(
          authRepository,
        ),
      );
  }
}
