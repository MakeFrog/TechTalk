import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:techtalk/features/auth/data/remote/auth_remote_data_source.dart';

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    return _firebaseAuth.signInWithProvider(appleProvider);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
