import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/service/Exceptions/authexception.dart';

class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<User?> get userChanges => _auth.userChanges();

  

  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) throw AuthException('Sign up failed');

      await user.updateDisplayName(username);
      await user.reload();

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException('This email address is already in use.');
        case 'weak-password':
          throw AuthException('The password is too weak (min. 6 characters).');
        case 'invalid-email':
          throw AuthException('Invalid email address.');
        default:
          throw AuthException('Sign up failed: ${e.message}');
      }
    } catch (e) {
      throw AuthException('Sign up failed for an unknown reason, please try again.');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException('Logout failed: ${e.message}');
    } catch (e) {
      throw AuthException('Logout failed for an unknown reason, please try again.');
    }
  }
}
