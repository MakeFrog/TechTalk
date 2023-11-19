import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/sign_up/data/remote/sign_up_remote_data_source.dart';
import 'package:techtalk/features/sign_up/repositories/sign_up_repository.dart';

final class SignUpRepositoryImpl implements SignUpRepository {
  const SignUpRepositoryImpl(
    this._signUpRemoteDataSource,
  );

  final SignUpRemoteDataSource _signUpRemoteDataSource;

  @override
  Future<Result<bool>> isExistNickname(String nickname) async {
    try {
      final isExist = await _signUpRemoteDataSource.isExistNickname(nickname);

      return Result.success(isExist);
    } on Exception catch (e, s) {
      return Result.failure(e);
    }
  }
}
