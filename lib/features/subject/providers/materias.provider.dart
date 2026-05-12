import 'package:flutter/material.dart';
import '../models/materias.model.dart';
import '../repositories/materias.repository.dart';


class SubjectProvider extends ChangeNotifier {
  
  final SubjectRepository _repository = SubjectRepository();

  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  /// INIT
  void loadSubjects() {
    _subjects = _repository.getAll();
    notifyListeners();
  }

  /// CREATE
  void addSubject(Subject subject) {
    _repository.add(subject);
    loadSubjects();
  }

  /// UPDATE
  void updateSubject(Subject subject) {
    _repository.update(subject);
    loadSubjects();
  }

  /// DELETE
  void deleteSubject(int id) {
    try {
      // Precaución al eliminar: Manejamos posibles restricciones de claves foráneas 
      // en caso de que la materia ya esté asociada a otras tablas.
      _repository.delete(id);
      loadSubjects();
    } catch (e) {
      debugPrint('Error al eliminar: Verifica que la materia no tenga claves foráneas en otras tablas. Detalle: $e');
      // Aquí podrías lanzar una excepción para capturarla en la UI y mostrar un SnackBar al usuario
      rethrow; 
    }
  }

  /// GET BY ID
  Subject? getById(int id) {
    return _repository.getById(id);
  }
}