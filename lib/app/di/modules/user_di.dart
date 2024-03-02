import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/module/app_local.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/data_source/local/user_local_data_source.dart';
import 'package:techtalk/features/user/data_source/local/user_local_data_source_impl.dart';
import 'package:techtalk/features/user/data_source/remote/user_remote_data_source_impl.dart';
import 'package:techtalk/features/user/repositories/user_repository_impl.dart';
import 'package:techtalk/features/user/usecases/check_nickname_duplication.dart';
import 'package:techtalk/features/user/usecases/disable_review_available_state_use_case.dart';
import 'package:techtalk/features/user/usecases/edit_user_profile_use_case.dart';
import 'package:techtalk/features/user/usecases/increase_completed_interview_count_use_case.dart';
import 'package:techtalk/features/user/usecases/sotre_user_local_info_use_case.dart';
import 'package:techtalk/features/user/usecases/update_last_login_date_use_cae.dart';
import 'package:techtalk/features/user/user.dart';

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
        techSetRepository,
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
