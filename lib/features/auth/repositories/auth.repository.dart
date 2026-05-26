import '../models/auth_user.model.dart';

class AuthRepository {
  // Credenciales de prueba en memoria (mismo patrón que el resto del proyecto)
  static const List<Map<String, String>> _users = [
    {'email': 'admin@uni.edu', 'password': '123456', 'name': 'Administrador'},
    {'email': 'docente@uni.edu', 'password': 'docente1', 'name': 'Docente'},
  ];

  /// Retorna el usuario si las credenciales son correctas, null si no.
  AuthUser? login(String email, String password) {
    try {
      final found = _users.firstWhere(
        (u) => u['email'] == email.trim() && u['password'] == password,
      );
      return AuthUser(
        email: found['email']!,
        password: found['password']!,
        name: found['name']!,
      );
    } catch (_) {
      return null;
    }
  }
}
