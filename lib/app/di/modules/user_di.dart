import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source_impl.dart';
import 'package:techtalk/features/user/repositories/user_repository_impl.dart';
import 'package:techtalk/features/user/user.dart';

final class UserDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<UserRemoteDataSource>(
      UserRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    final userRemoteDataSource = locator<UserRemoteDataSource>();

    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    final userRepository = locator<UserRepository>();

    locator
      ..registerFactory<CreateUserDataUseCase>(
        () => CreateUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory<GetUserDataUseCase>(
        () => GetUserDataUseCase(
          userRepository,
        ),
      );
  }
}
