import 'package:flutter/material.dart';
import '../models/student.model.dart';
import '../repositories/student.repository.dart';

class StudentProvider extends ChangeNotifier {
  
  final StudentRepository _repository = StudentRepository();

  List<Student> _students = [];

  List<Student> get students => _students;

  /// INIT
  void loadStudents() {
    _students = _repository.getAll();
    notifyListeners();
  }

  /// CREATE
  void addStudent(Student student) {
    _repository.add(student);
    loadStudents();
  }

  /// UPDATE
  void updateStudent(Student student) {
    _repository.update(student);
    loadStudents();
  }

  /// DELETE
  void deleteStudent(int id) {
    _repository.delete(id);
    loadStudents();
  }

  Student? getById(int id) {
    return _repository.getById(id);
  }
}
