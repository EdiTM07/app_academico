import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.model.dart';

class UserRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final String _collection = 'users';

  /// ============================
  /// GET ALL
  /// ============================
  Future<List<User>> getAll() async {
    final snapshot =
        await _firestore.collection(_collection).get();

    return snapshot.docs.map((doc) {
      return User.fromJson(
        doc.data(),
        id: doc.id,
      );
    }).toList();
  }

  /// ============================
  /// GET BY ID
  /// ============================
  Future<User?> getById(String id) async {
    final doc =
        await _firestore.collection(_collection).doc(id).get();

    if (!doc.exists) return null;

    return User.fromJson(
      doc.data()!,
      id: doc.id,
    );
  }

  /// ============================
  /// CREATE
  /// ============================
  Future<void> create(User user) async {
    await _firestore
        .collection(_collection)
        .doc(user.id)
        .set(user.toJson());
  }

  /// ============================
  /// UPDATE
  /// ============================
  Future<void> update(User user) async {
    await _firestore
        .collection(_collection)
        .doc(user.id)
        .update(user.toJson());
  }

  /// ============================
  /// DELETE
  /// ============================
  Future<void> delete(String id) async {
    await _firestore
        .collection(_collection)
        .doc(id)
        .delete();
  }
}
