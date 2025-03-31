import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/core/modules/local/app_local.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/index.dart';

final class UserDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<UserRemoteDataSource>(
        UserRemoteDataSourceImpl.new,
      )
      ..registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImpl(AppLocal.userBox),
      );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource,
        userLocalDataSource,
        youtubeRemoteDataSource,
        techSetRepository,
        topicRepository,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => CreateUserUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => GetUserUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => UpdateUserUseCase(
          userRepository,
        ),
      )
      ..registerFactory(
        () => ResignUserInfoUseCase(
          userRepository,
          topicRepository,
        ),
      )
      ..registerFactory(
        () => EditUserProfileUseCase(userRepository),
      )
      ..registerFactory(
        () => CheckNicknameDuplication(userRepository),
      )
      ..registerFactory(
        () => StoreUserLocalInfoUseCase(userRepository),
      )
      ..registerFactory(
        () => UpdateLastLoginDateUseCase(userRepository),
      )
      ..registerFactory(
        () => IncreaseCompletedInterviewCountUseCase(userRepository),
      )
      ..registerFactory(
        () => DisableReviewAvailableStateUseCase(userRepository),
      );
  }
}
