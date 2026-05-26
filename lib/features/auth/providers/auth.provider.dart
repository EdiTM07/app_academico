import 'package:flutter/material.dart';
import '../models/auth_user.model.dart';
import '../repositories/auth.repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  AuthUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AuthUser? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Intenta autenticar al usuario con email y password.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulamos una pequeña espera como si fuera una llamada a API
    await Future.delayed(const Duration(milliseconds: 800));

    final user = _repository.login(email, password);

    if (user != null) {
      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Correo o contraseña incorrectos.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Cierra la sesión del usuario actual.
  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }
}
