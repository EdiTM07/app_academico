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
      }, id: doc.id);
    }).toList();
  }

  /// ============================
  /// GET BY ID
  /// ============================
  Future<Student?> getById(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return Student.fromJson({
      ...data,
      'birthDate': (data['birthDate'] as Timestamp).toDate().toIso8601String(),
    }, id: doc.id);
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
    await _firestore.collection(_collection).doc(student.id).update({
      ...student.toJson(),
      'birthDate': Timestamp.fromDate(student.birthDate),
    });
  }

  /// ============================
  /// DELETE
  /// ============================
  Future<void> delete(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
