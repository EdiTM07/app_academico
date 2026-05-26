import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/academic.program.model.dart';

class AcademicProgramRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'academic_program';

  /// ============================
  /// GET ALL
  /// ============================
  Future<List<AcademicProgram>> getAll() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return AcademicProgram.fromJson(data);
    }).toList();
  }

  /// ============================
  /// GET BY ID
  /// ============================
  Future<AcademicProgram?> getById(int id) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    final data = snapshot.docs.first.data();
    return AcademicProgram.fromJson(data);
  }
}
