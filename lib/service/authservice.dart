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
      if (user == null) {
        throw AuthException(
          'Sign up failed for an unknown reason, please try again.',
        );
      }

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
        case 'network-request-failed':
          throw AuthException(
            'Network error. Please check your internet connection.',
          );
        default:
          throw AuthException('Sign up failed: ${e.message}');
      }
    } catch (e) {
      throw AuthException(
        'Sign up failed for an unknown reason, please try again.',
      );
    }
  }

  Future<User?> logIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        throw AuthException(
          'Login failed for an unknown reason, please try again.',
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Please enter a valid email address.');
        case 'invalid-credential':
        case 'user-not-found':
        case 'wrong-password':
          throw AuthException('Incorrect email or password.');
        case 'user-disabled':
          throw AuthException('This account has been disabled.');
        case 'too-many-requests':
          throw AuthException(
            'Too many failed attempts. Please wait a moment and try again.',
          );
        case 'network-request-failed':
          throw AuthException(
            'Network error. Please check your internet connection.',
          );
        case 'operation-not-allowed':
          throw AuthException(
            'Email/password login is currently not available.',
          );
        default:
          throw AuthException('Login failed: ${e.message}');
      }
    } catch (e) {
      throw AuthException(
        'Login failed for an unknown reason, please try again.',
      );
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
