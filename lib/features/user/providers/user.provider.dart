import 'package:flutter/material.dart';

import '../models/user.model.dart';
import '../repositories/user.repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository =
      UserRepository();

  List<User> _users = [];

  List<User> get users => _users;

  User? _currentUser;

  User? get currentUser => _currentUser;

  /// ============================
  /// LOAD ALL
  /// ============================
  Future<void> loadUsers() async {
    _users = await _repository.getAll();

    notifyListeners();
  }

  /// ============================
  /// LOAD CURRENT USER
  /// ============================
  Future<void> loadUserById(String id) async {
    _currentUser =
        await _repository.getById(id);

    notifyListeners();
  }

  /// ============================
  /// CLEAR CURRENT USER
  /// ============================
  void clearCurrentUser() {
    _currentUser = null;

    notifyListeners();
  }

  /// ============================
  /// CREATE
  /// ============================
  Future<void> addUser(User user) async {
    await _repository.create(user);

    await loadUsers();
  }

  /// ============================
  /// UPDATE
  /// ============================
  Future<void> updateUser(User user) async {
    await _repository.update(user);

    await loadUsers();
  }

  /// ============================
  /// DELETE
  /// ============================
  Future<void> deleteUser(String id) async {
    await _repository.delete(id);

    await loadUsers();
  }
}
