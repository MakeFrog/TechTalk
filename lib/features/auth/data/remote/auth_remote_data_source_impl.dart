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
    // Trigger the authentication flow
    final googleUser =
        await GoogleSignIn().signInSilently() ?? await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
