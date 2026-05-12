import '../models/materias.model.dart'; 

class SubjectRepository {
  final List<Subject> _subjects = [
    Subject(
      id: 1,
      code: "MAT001",
      name: "Bases de Datos",
      credits: 4,
      hours: 64,
      knowledgeArea: "Ingeniería de Software",
    ),
    Subject(
      id: 2,
      code: "MAT002",
      name: "Desarrollo Web Frontend",
      credits: 3,
      hours: 48,
      knowledgeArea: "Programación",
    ),
    Subject(
      id: 3,
      code: "MAT003",
      name: "Metodologías Ágiles",
      credits: 3,
      hours: 48,
      knowledgeArea: "Gestión de Proyectos",
    ),
  ];

  /// GET ALL
  List<Subject> getAll() {
    return _subjects;
  }

  /// GET BY ID
  Subject? getById(int id) {
    return _subjects.firstWhere(
      (s) => s.id == id,
      orElse: () => throw Exception("Materia no encontrada"),
    );
  }

  /// INSERT
  void add(Subject subject) {
    _subjects.add(subject);
  }

  /// UPDATE
  void update(Subject subject) {
    final index = _subjects.indexWhere((s) => s.id == subject.id);
    if (index != -1) {
      _subjects[index] = subject;
    }
  }

  /// DELETE
  void delete(int id) {
    _subjects.removeWhere((s) => s.id == id);
  }
}