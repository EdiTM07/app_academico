import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/materias.model.dart';

class SubjectRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'subjects';

  /// ============================
  /// GET ALL
  /// ============================
  Future<List<Subject>> getAll() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Subject.fromJson(data);
    }).toList();
  }

  /// ============================
  /// GET BY ID
  /// ============================
  Future<Subject?> getById(int id) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    final data = snapshot.docs.first.data();
    return Subject.fromJson(data);
  }

  /// ============================
  /// INSERT
  /// ============================
  Future<void> add(Subject subject) async {
    await _firestore.collection(_collection).add(subject.toJson());
  }

  /// ============================
  /// UPDATE
  /// ============================
  Future<void> update(Subject subject) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: subject.id)
        .get();
    if (snapshot.docs.isEmpty) {
      throw Exception('Subject not found');
    }
    final docId = snapshot.docs.first.id;
    await _firestore
        .collection(_collection)
        .doc(docId)
        .update(subject.toJson());
  }

  /// ============================
  /// DELETE
  /// ============================
  Future<void> delete(int id) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return;
    }
    final docId = snapshot.docs.first.id;
    await _firestore.collection(_collection).doc(docId).delete();
  }
}
