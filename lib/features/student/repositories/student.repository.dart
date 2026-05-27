import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.model.dart';

class StudentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'students';

  /// ============================
  /// GET ALL
  /// ============================
  Future<List<Student>> getAll() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Student.fromJson({
        ...data,
        /// Convertir timestamp a string
        'birthDate': (data['birthDate'] as Timestamp)
            .toDate()
            .toIso8601String(),
      });
    }).toList();
  }

  /// ============================
  /// GET BY ID
  /// ============================
  Future<Student?> getById(int id) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    final data = snapshot.docs.first.data();
    return Student.fromJson({
      ...data,
      'birthDate': (data['birthDate'] as Timestamp).toDate().toIso8601String(),
    });
  }

  /// ============================
  /// INSERT
  /// ============================
  Future<void> add(Student student) async {
    await _firestore.collection(_collection).add({
      ...student.toJson(),
      'birthDate': Timestamp.fromDate(student.birthDate),
    });
  }

  /// ============================
  /// UPDATE
  /// ============================
  Future<void> update(Student student) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: student.id)
        .get();
    if (snapshot.docs.isEmpty) {
      throw Exception('Student not found');
    }
    final docId = snapshot.docs.first.id;
    await _firestore.collection(_collection).doc(docId).update({
      ...student.toJson(),
      'birthDate': Timestamp.fromDate(student.birthDate),
    });
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
