import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/auth/data_source/remote/auth_remote_data_source.dart';
import 'package:techtalk/features/auth/repositories/auth_repository.dart';
import 'package:techtalk/features/auth/usecases/sign_in_oauth_use_case.dart';
import 'package:techtalk/features/auth/usecases/sign_out_use_case.dart';

export 'auth.dart';
export 'data_source/remote/auth_remote_data_source.dart';
export 'data_source/remote/auth_remote_data_source_impl.dart';
export 'repositories/auth_repository.dart';
export 'repositories/auth_repository_impl.dart';
export 'repositories/entities/user_account_provider.enum.dart';
export 'usecases/sign_in_oauth_use_case.dart';
export 'usecases/sign_out_use_case.dart';

final authRemoteDataSource = locator<AuthRemoteDataSource>();
final authRepository = locator<AuthRepository>();
final signInOAuthUseCase = locator<SignInOAuthUseCase>();
final signOutUseCase = locator<SignOutUseCase>();
