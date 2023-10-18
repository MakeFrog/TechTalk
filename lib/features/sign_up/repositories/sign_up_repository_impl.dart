import 'package:techtalk/features/sign_up/data/remote/sign_up_remote_data_source.dart';
import 'package:techtalk/features/sign_up/repositories/sign_up_repository.dart';

final class SignUpRepositoryImpl implements SignUpRepository {
  const SignUpRepositoryImpl(
    this._signUpRemoteDataSource,
  );

  final SignUpRemoteDataSource _signUpRemoteDataSource;

  @override
  Future<bool> isExistNickname(String nickname) {
    return _signUpRemoteDataSource.isExistNickname(nickname);
  }
}
