import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:techtalk/features/auth/repositories/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._authRemoteDataSource,
  );

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<UserCredential> signInOAuth(UserAccountProvider provider) async {
    try {
      final userCredential = await switch (provider) {
        UserAccountProvider.google => _authRemoteDataSource.signInWithGoogle(),
        UserAccountProvider.apple => _authRemoteDataSource.signInWithApple(),
      };

      return userCredential;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    return _authRemoteDataSource.signOut();
  }
}
