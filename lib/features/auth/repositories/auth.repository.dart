import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthRepository {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  /// ============================
  /// CURRENT USER
  /// ============================
  fb.User? get currentUser => _auth.currentUser;

  /// ============================
  /// LOGIN
  /// ============================
  Future<fb.UserCredential> login(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// ============================
  /// REGISTER
  /// ============================
  Future<fb.UserCredential> register(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// ============================
  /// LOGOUT
  /// ============================
  Future<void> logout() async {
    await _auth.signOut();
  }
}
