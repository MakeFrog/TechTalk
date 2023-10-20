import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/features/auth/auth.dart';

class AuthRemoteDataSourceFake implements AuthRemoteDataSource {
  @override
  Future<UserCredential> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
