import 'package:techtalk/features/sign_up/sign_up.dart';

final class SignUpRepositoryImpl implements SignUpRepository {
  const SignUpRepositoryImpl(
    this._signUpRemoteDataSource,
  );

  final SignUpRemoteDataSource _signUpRemoteDataSource;

  @override
  Future<void> createUserData(String uid) async {
    await _signUpRemoteDataSource.createUserData(uid);
  }
}
