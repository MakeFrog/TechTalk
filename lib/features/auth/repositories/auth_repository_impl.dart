import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/auth/data_source/remote/auth_remote_data_source.dart';
import 'package:techtalk/features/auth/repositories/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._authRemoteDataSource,
  );

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<Result<UserCredential>> signInOAuth(
    UserAccountProvider provider,
  ) async {
    try {
      final userCredential = await switch (provider) {
        UserAccountProvider.google => _authRemoteDataSource.signInWithGoogle(),
        UserAccountProvider.apple => _authRemoteDataSource.signInWithApple(),
      };

      return Result.success(userCredential);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      return Result.success(
        await _authRemoteDataSource.signOut(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
