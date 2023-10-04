import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';

final class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signInOAuth(UserAccountProvider provider) async {
    final authProvider = switch (provider) {
      UserAccountProvider.google => GoogleAuthProvider(),
      UserAccountProvider.apple => AppleAuthProvider(),
    };

    final credential = await _firebaseAuth.signInWithProvider(authProvider);

    final uid = credential.user!.uid;
  }
}
