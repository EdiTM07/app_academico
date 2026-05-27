import '../models/document.model.dart'; // Asegúrate de ajustar la ruta al modelo AppDocument

class DocumentRepository {
  final List<AppDocument> _documents = [
    AppDocument(
      id: 1,
      documentNumber: "SOL-2026-001",
      type: "Solicitud",
      title: "Justificación de faltas por salud",
      content:
          "Por medio de la presente, solicito comedidamente se justifiquen mis faltas de los días 12 y 13 de mayo debido a una cita médica de urgencia. Adjunto el certificado correspondiente.",
      studentId: 3,
      sender: "Edison Tituana",
      receiver: "Coordinación de Carrera",
      department: "Coordinación Académica",
      status: "En revisión",
      priority: "Urgente",
      createdAt: DateTime(2026, 5, 14),
      approvalDate: null,
      attachmentUrl: "evidencia_medica.pdf",
    ),
    AppDocument(
      id: 2,
      documentNumber: "SOL-2026-002",
      type: "Solicitud",
      title: "Permiso por calamidad domestica",
      content:
          "Por medio de la presente, solicito comedidamente se justifiquen mis faltas de los días 12 y 13 de mayo debido a una cita médica de urgencia. Adjunto el certificado correspondiente.",
      studentId: 2,
      sender: "Jessica Torres",
      receiver: "Coordinación de Carrera",
      department: "Coordinación Académica",
      status: "Aprobado",
      priority: "Urgente",
      createdAt: DateTime(2026, 5, 14),
      approvalDate: null,
      attachmentUrl: "evidencia_medica.pdf",
    ),
    AppDocument(
      id: 2,
      documentNumber: "OFI-2026-015",
      type: "Oficio",
      title: "Petición de cambio de jornada",
      content:
          "Estimados directivos, presento esta comunicación para requerir formalmente el traspaso de la jornada matutina a la nocturna, motivado por cruces de horarios con mi actual empleo laboral.",
      studentId: 1,
      sender: "Juan Pérez",
      receiver: "Secretaría Académica",
      department: "Secretaría",
      status: "Aprobado",
      priority: "Normal",
      createdAt: DateTime(2026, 5, 10),
      approvalDate: DateTime(2026, 5, 12),
      attachmentUrl: null,
    ),
  ];

  /// GET ALL - Retorna todas las solicitudes registradas
  List<AppDocument> getAll() {
    return _documents;
  }

  /// GET BY ID - Busca un documento por su identificador único numérico
  AppDocument? getById(int id) {
    return _documents.firstWhere(
      (doc) => doc.id == id,
      orElse: () => throw Exception("Documento no encontrado"),
    );
  }

  /// INSERT - Añade un nuevo trámite al sistema
  void add(AppDocument document) {
    _documents.add(document);
  }

  /// UPDATE - Actualiza los datos de un documento existente (Ej: cambiar de "En revisión" a "Aprobado")
  void update(AppDocument document) {
    final index = _documents.indexWhere((doc) => doc.id == document.id);
    if (index != -1) {
      _documents[index] = document;
    }
  }

  /// DELETE - Elimina físicamente un registro mediante su ID
  void delete(int id) {
    _documents.removeWhere((doc) => doc.id == id);
  }
}
