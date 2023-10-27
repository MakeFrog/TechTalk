import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source_impl.dart';
import 'package:techtalk/features/user/repositories/user_repository_impl.dart';
import 'package:techtalk/features/user/user.dart';

final class UserDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I.registerLazySingleton<UserRemoteDataSource>(
      UserRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    GetIt.I.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    GetIt.I
      ..registerFactory<CreateUserDataUseCase>(
        () => CreateUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory<GetUserDataUseCase>(
        () => GetUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory<IsExistNicknameUseCase>(
        () => IsExistNicknameUseCase(
          userRepository,
        ),
      );
  }
}
