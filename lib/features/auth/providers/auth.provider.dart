import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';

import '../../user/models/user.model.dart';
import '../../user/providers/user.provider.dart';
import '../../user/repositories/user.repository.dart';
import '../repositories/auth.repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  final UserRepository _userRepository = UserRepository();

  final UserProvider userProvider;

  AuthProvider({required this.userProvider});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  /// ============================
  /// INIT SESSION
  /// ============================
   Future<void> initAuth() async {
    final firebaseUser = _authRepository.currentUser;

    if (firebaseUser == null) {
      _isAuthenticated = false;

      userProvider.clearCurrentUser();

      notifyListeners();

      return;
    }

    await userProvider.loadUserById(firebaseUser.uid);

    if (userProvider.currentUser == null) {
      _isAuthenticated = false;

      return;
    }

    _isAuthenticated = true;

    notifyListeners();
  }

  /// ============================
  /// LOGIN
  /// ============================
Future<void> login(String email, String password) async {
    _setLoading(true);

    try {
      final credential = await _authRepository.login(email, password);

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw Exception('Usuario inválido');
      }

      // Intentamos cargar los datos del perfil desde Firestore (opcional)
      await userProvider.loadUserById(firebaseUser.uid);

      _isAuthenticated = true;
      _errorMessage = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// ============================
  /// REGISTER
  /// ============================
  Future<void> register(User user, String password) async {
    _setLoading(true);

    try {
      final credential = await _authRepository.register(user.email, password);

      final uid = credential.user!.uid;

      final newUser = user.copyWith(id: uid);

      await _userRepository.create(newUser);

      await userProvider.loadUserById(uid);

      _isAuthenticated = true;

      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();

      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// ============================
  /// LOGOUT
  /// ============================
  Future<void> logout() async {
    await _authRepository.logout();

    userProvider.clearCurrentUser();

    _isAuthenticated = false;

    notifyListeners();
  }

  /// ============================
  /// LOADING
  /// ============================
  void _setLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }
}
