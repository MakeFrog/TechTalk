import 'package:techtalk/features/sign_up/sign_up.dart';

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
