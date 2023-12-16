import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';
import 'package:techtalk/features/user/usecases/create_user_data_use_case.dart';
import 'package:techtalk/features/user/usecases/delete_user_data_use_case.dart';
import 'package:techtalk/features/user/usecases/get_user_data_use_case.dart';
import 'package:techtalk/features/user/usecases/get_user_topics_use_case.dart';
import 'package:techtalk/features/user/usecases/update_user_data_use_case.dart';

export 'data/remote/user_remote_data_source.dart';
export 'entities/user_data_entity.dart';
export 'repositories/user_repository.dart';
export 'usecases/create_user_data_use_case.dart';
export 'usecases/delete_user_data_use_case.dart';
export 'usecases/get_user_data_use_case.dart';
export 'usecases/get_user_topics_use_case.dart';
export 'usecases/update_user_data_use_case.dart';

final userRemoteDataSource = locator<UserRemoteDataSource>();
final userRepository = locator<UserRepository>();
final createUserDataUseCase = locator<CreateUserDataUseCase>();
final updateUserDataUseCase = locator<UpdateUserDataUseCase>();
final getUserDataUseCase = locator<GetUserDataUseCase>();
final deleteUserDataUseCase = locator<DeleteUserDataUseCase>();
final getUserInterviewTopicsUseCase = locator<GetUserTopicsUseCase>();
