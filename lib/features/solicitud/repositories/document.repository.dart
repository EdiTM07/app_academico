
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/document.model.dart';

class DocumentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'documents';

  /// =============================
  /// GET ALL
  /// =============================
  Future<List<AppDocument>> getAll() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return AppDocument.fromJson({
        ...data,
        'createdAt': (data['createdAt'] as Timestamp)
            .toDate()
            .toIso8601String(),
        'approvalDate': (data['approvalDate'] as Timestamp?)
            ?.toDate()
            .toIso8601String(),
      });
    }).toList();
  }

  /// =============================
  /// GET BY ID
  /// =============================
  Future<AppDocument?> getById(int id) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    final data = snapshot.docs.first.data();
    return AppDocument.fromJson({
      ...data,
      'createdAt': (data['createdAt'] as Timestamp)
          .toDate()
          .toIso8601String(),
      'approvalDate': (data['approvalDate'] as Timestamp?)
          ?.toDate()
          .toIso8601String(),
    });
  }

  /// =============================
  /// INSERT
  /// =============================
  Future<void> add(AppDocument document) async {
    await _firestore.collection(_collection).add({
      ...document.toJson(),
      'createdAt': Timestamp.fromDate(document.createdAt),
      'approvalDate': document.approvalDate == null
          ? null
          : Timestamp.fromDate(document.approvalDate!),
    });
  }

  /// =============================
  /// UPDATE
  /// =============================
  Future<void> update(AppDocument document) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: document.id)
        .get();
    if (snapshot.docs.isEmpty) {
      throw Exception('Document not found');
    }
    final docId = snapshot.docs.first.id;
    await _firestore.collection(_collection).doc(docId).update({
      ...document.toJson(),
      'createdAt': Timestamp.fromDate(document.createdAt),
      'approvalDate': document.approvalDate == null
          ? null
          : Timestamp.fromDate(document.approvalDate!),
    });
  }

  /// =============================
  /// DELETE
  /// =============================
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
