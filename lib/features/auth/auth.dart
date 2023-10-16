import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:techtalk/features/auth/repositories/auth_repository.dart';

export 'data/remote/auth_remote_data_source.dart';
export 'repositories/auth_repository.dart';

final authRemoteDataSource = locator<AuthRemoteDataSource>();
final authRepository = locator<AuthRepository>();
