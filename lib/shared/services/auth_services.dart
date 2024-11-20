import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebasthAuth = FirebaseAuth.instance;

  User? get currentUser => _firebasthAuth.currentUser;

  Stream<User?> get authStateChanges => _firebasthAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _firebasthAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPaassword(String email, String password) {
    return _firebasthAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> deleteAccount(String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Create email/password credential
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // Reauthenticate the user
      await user.reauthenticateWithCredential(credential);

      return await user.delete();
    }
  }

  Future<void> signOut() {
    return _firebasthAuth.signOut();
  }
}
