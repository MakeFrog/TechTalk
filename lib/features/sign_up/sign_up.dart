import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/sign_up/data/remote/sign_up_remote_data_source.dart';
import 'package:techtalk/features/sign_up/repositories/sign_up_repository.dart';

export '../user/usecases/is_exist_nickname_use_case.dart';
export 'data/remote/sign_up_remote_data_source.dart';
export 'repositories/sign_up_repository.dart';

final signUpRemoteDataSource = locator<SignUpRemoteDataSource>();
final signUpRepository = locator<SignUpRepository>();
