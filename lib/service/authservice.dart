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
      if (user == null) throw AuthException('Registrierung fehlgeschlagen');

      await user.updateDisplayName(username);
      await user.reload();

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException('Diese E-Mail wird bereits verwendet.');
        case 'weak-password':
          throw AuthException('Das Passwort ist zu schwach (min. 6 Zeichen).');
        case 'invalid-email':
          throw AuthException('Ungültige E-Mail-Adresse.');
        default:
          throw AuthException('Registrierung fehlgeschlagen: ${e.message}');
      }
    } catch (e) {
      throw AuthException(
        'Registrierung fehlgeschlagen aus nicht bekannten gründen, versuchen sie es noch einmal',
      );
    }
  }
}
