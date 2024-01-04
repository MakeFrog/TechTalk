import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';
import 'package:techtalk/features/user/usecases/create_user_use_case.dart';
import 'package:techtalk/features/user/usecases/delete_user_use_case.dart';
import 'package:techtalk/features/user/usecases/get_user_use_case.dart';
import 'package:techtalk/features/user/usecases/update_user_use_case.dart';

export 'data/remote/user_remote_data_source.dart';
export 'entities/user_entity.dart';
export 'repositories/user_repository.dart';
export 'usecases/create_user_use_case.dart';
export 'usecases/delete_user_use_case.dart';
export 'usecases/get_user_use_case.dart';
export 'usecases/update_user_use_case.dart';

final userRemoteDataSource = locator<UserRemoteDataSource>();
final userRepository = locator<UserRepository>();
final createUserUseCase = locator<CreateUserUseCase>();
final updateUserUseCase = locator<UpdateUserUseCase>();
final getUserUseCase = locator<GetUserUseCase>();
final deleteUserUseCase = locator<DeleteUserUseCase>();
