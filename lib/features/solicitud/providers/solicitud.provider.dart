import 'package:flutter/material.dart';
import '../models/solicitud.model.dart';
import '../repositories/solicitud.repository.dart';

class DocumentProvider extends ChangeNotifier {
  
  final DocumentRepository _repository = DocumentRepository();

  List<AppDocument> _documents = [];

  List<AppDocument> get documents => _documents;

  /// INIT - Carga todos los documentos/solicitudes del sistema
  void loadDocuments() {
    _documents = _repository.getAll();
    notifyListeners();
  }

  /// CREATE - Registra una nueva solicitud u oficio
  void addDocument(AppDocument document) {
    _repository.add(document);
    loadDocuments(); // Recarga la lista y notifica a la UI automáticamente
  }

  /// UPDATE - Permite editar el documento (Ej: cambiar el estado a 'Aprobado' o 'Rechazado')
  void updateDocument(AppDocument document) {
    _repository.update(document);
    loadDocuments();
  }

  /// DELETE - Elimina un documento del sistema por su ID
  void deleteDocument(int id) {
    _repository.delete(id);
    loadDocuments();
  }

  /// GET BY ID - Obtiene una solicitud específica por su llave primaria
  AppDocument? getById(int id) {
    return _repository.getById(id);
  }

  /// HELPER: Filtrar solicitudes por Estudiante
  /// Útil para el historial dentro del perfil del estudiante
  List<AppDocument> getDocumentsByStudent(int studentId) {
    return _documents.where((doc) => doc.studentId == studentId).toList();
  }

  /// HELPER: Filtrar solicitudes por Estado (Borrador, Enviado, En revisión, Aprobado)
  /// Útil para las bandejas de entrada de la Coordinación Académica o Secretaría
  List<AppDocument> getDocumentsByStatus(String status) {
    return _documents.where((doc) => doc.status.toLowerCase() == status.toLowerCase()).toList();
  }
}