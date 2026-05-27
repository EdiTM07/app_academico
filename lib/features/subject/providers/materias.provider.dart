import 'package:flutter/material.dart';

import '../models/materias.model.dart';
import '../models/materias.view.dart';
import '../repositories/materias.repository.dart';

class SubjectProvider extends ChangeNotifier {
  final SubjectRepository _repository = SubjectRepository();

  List<SubjectView> _subjects = [];

  List<SubjectView> get subjects => _subjects;

  /// INIT
  Future<void> loadSubjects() async {
    final subjects = await _repository.getAll();
    _subjects = subjects.map((subject) => SubjectView(subject: subject)).toList();
    notifyListeners();
  }

  /// CREATE
  Future<void> addSubject(Subject subject) async {
    await _repository.add(subject);
    await loadSubjects();
  }

  /// UPDATE
  Future<void> updateSubject(Subject subject) async {
    await _repository.update(subject);
    await loadSubjects();
  }

  /// DELETE
  Future<void> deleteSubject(int id) async {
    await _repository.delete(id);
    await loadSubjects();
  }

  /// GET BY ID
  Future<Subject?> getById(int id) async {
    return await _repository.getById(id);
  }
}