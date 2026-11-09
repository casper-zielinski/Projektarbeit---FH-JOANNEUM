import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/service/Exceptions/authexception.dart';
import 'package:flutterapp/service/dto/authorized.dart';

class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  static final String guestUserEmail = "guest123@gmail.com";
  static final String guestUserPassword = "MeinPasswort1!";

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

      Authorized.authenticate();
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

      Authorized.authenticate();
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

  Future<User?> logInAsGuest() async {
    try {
      User? guestUser = await logIn(
        email: guestUserEmail,
        password: guestUserPassword,
      );
      Authorized.authenticate();
      Authorized.isGuest = true;
      return guestUser;
    } on AuthException catch (e) {
      switch (e.message) {
        case 'Network error. Please check your internet connection.':
        case 'Email/password login is currently not available.':
        case 'Too many failed attempts. Please wait a moment and try again.':
          rethrow;
        case 'Login failed for an unknown reason, please try again.':
          throw AuthException(
            'Guest Login failed for an unknown reason, please try again.',
          );
        default:
          throw AuthException(
            'Guest Login failed for an unknown reason, please try again.',
          );
      }
    } catch (e) {
      throw AuthException(
        'Guest Login failed for an unknown reason, please try again.',
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Authorized.isAuthenticated = false;
      Authorized.isGuest = false;
    } on FirebaseAuthException catch (e) {
      throw AuthException('Logout failed: ${e.message}');
    } catch (e) {
      throw AuthException(
        'Logout failed for an unknown reason, please try again.',
      );
    }
  }
}
