import 'package:flutter/material.dart';
import '../../career/repository/career.repository.dart';
import '../models/student.model.dart';
import '../models/student_view.dart';
import '../repositories/student.repository.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _studentRepo = StudentRepository();
  final CareerRepository _careerRepo = CareerRepository();

  List<StudentView> _studentsView = [];
  List<StudentView> get students => _studentsView;

  void loadStudents() {
    final rawStudents = _studentRepo.getAll(); 
    final careers = _careerRepo.getAll();

    _studentsView = rawStudents.map((student) {
      final career = careers.firstWhere(
        (c) => c.id == student.careerId,
        orElse: () => throw Exception("Carrera no encontrada"),
      );
      
      return StudentView(
        student: student,
        career: career,
      );
    }).toList();

    notifyListeners(); 
  }

  void addStudent(Student student) {
    _studentRepo.add(student);
    loadStudents();
  }

  void updateStudent(Student student) {
    _studentRepo.update(student);
    loadStudents();
  }

  void deleteStudent(int id) {
    _studentRepo.delete(id);
    loadStudents();
  }

  Student? getById(int id) => _studentRepo.getById(id);
}