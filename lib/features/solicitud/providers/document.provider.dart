import 'package:flutter/material.dart';
import '../models/document.model.dart';
import '../repositories/document.repository.dart';

class DocumentProvider extends ChangeNotifier {
  final DocumentRepository _repository = DocumentRepository();
  List<AppDocument> _documents = [];
  List<AppDocument> get documents => _documents;
  
  /// =====================
  /// INIT
  /// =====================
  Future<void> loadDocuments() async {
    _documents = await _repository.getAll();
    notifyListeners();
  }
  
  /// =====================
  /// CREATE
  /// =====================
  Future<void> addDocument(AppDocument document) async {
    await _repository.add(document);
    await loadDocuments();
  }
  
  /// =====================
  /// UPDATE
  /// =====================
  Future<void> updateDocument(AppDocument document) async {
    await _repository.update(document);
    await loadDocuments();
  }
  
  /// =====================
  /// DELETE
  /// =====================
  Future<void> deleteDocument(int id) async {
    await _repository.delete(id);
    await loadDocuments();
  }
  
  /// =====================
  /// GET BY ID
  /// =====================
  Future<AppDocument?> getById(int id) async {
    return await _repository.getById(id);
  }
  
  /// =====================
  /// FILTER BY STUDENT
  /// =====================
  List<AppDocument> getDocumentsByStudent(int studentId) {
    return _documents.where((doc) => doc.studentId == studentId).toList();
  }
  
  /// =====================
  /// FILTER BY STATUS
  /// =====================
  List<AppDocument> getDocumentsByStatus(String status) {
    return _documents.where((doc) => doc.status.toLowerCase() == status.toLowerCase()).toList();
  }
}