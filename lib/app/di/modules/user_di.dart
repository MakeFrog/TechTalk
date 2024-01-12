import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source_impl.dart';
import 'package:techtalk/features/user/repositories/user_repository_impl.dart';
import 'package:techtalk/features/user/usecases/check_is_nickname_duplicated_use_case.dart';
import 'package:techtalk/features/user/usecases/edit_user_profile_use_case.dart';
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
    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource,
        techSetRepository,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => CreateUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => GetUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => UpdateUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => DeleteUserDataUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => EditUserProfileUseCase(userRepository),
      )
      ..registerFactory(
        () => CheckIsNicknameDuplicatedUseCase(userRepository),
      );
  }
}
