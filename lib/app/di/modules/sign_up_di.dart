import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/sign_up/data/remote/sign_up_remote_data_source_impl.dart';
import 'package:techtalk/features/sign_up/repositories/sign_up_repository_impl.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

class SignUpDependencyInjection implements FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<SignUpRemoteDataSource>(
      SignUpRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(
        signUpRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => CreateUserDataUseCase(signUpRepository),
      );
  }
}
