import 'package:get_it/get_it.dart';
import 'package:techtalk/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:techtalk/features/auth/repositories/auth_repository.dart';
import 'package:techtalk/features/auth/usecases/sign_in_oauth_use_case.dart';
import 'package:techtalk/features/auth/usecases/sign_out_use_case.dart';

export 'data/remote/auth_remote_data_source.dart';
export 'repositories/auth_repository.dart';
export 'usecases/sign_in_oauth_use_case.dart';
export 'usecases/sign_out_use_case.dart';

final authRemoteDataSource = GetIt.I<AuthRemoteDataSource>();
final authRepository = GetIt.I<AuthRepository>();
final signInOAuthUseCase = GetIt.I<SignInOAuthUseCase>();
final signOutUseCase = GetIt.I<SignOutUseCase>();
