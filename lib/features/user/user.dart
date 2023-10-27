import 'package:get_it/get_it.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';
import 'package:techtalk/features/user/usecases/create_user_data_use_case.dart';
import 'package:techtalk/features/user/usecases/get_user_data_use_case.dart';
import 'package:techtalk/features/user/usecases/is_exist_nickname_use_case.dart';

export 'data/remote/user_remote_data_source.dart';
export 'repositories/user_repository.dart';
export 'usecases/create_user_data_use_case.dart';
export 'usecases/get_user_data_use_case.dart';
export 'usecases/is_exist_nickname_use_case.dart';

final userRemoteDataSource = GetIt.I<UserRemoteDataSource>();
final userRepository = GetIt.I<UserRepository>();
final isExistNicknameUseCase = GetIt.I<IsExistNicknameUseCase>();
final createUserDataUseCase = GetIt.I<CreateUserDataUseCase>();
final getUserDataUseCase = GetIt.I<GetUserDataUseCase>();
