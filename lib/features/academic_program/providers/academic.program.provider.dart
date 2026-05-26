import 'package:flutter/material.dart';
import '../models/academic.program.model.dart';
import '../repositories/academic.program.repository.dart';

class AcademicProgramProvider extends ChangeNotifier {
  final AcademicProgramRepository _repository = AcademicProgramRepository();
  List<AcademicProgram> _academicPrograms = [];
  List<AcademicProgram> get academicPrograms => _academicPrograms;

  /// ============================
  /// INIT
  /// ============================
  Future<void> loadAcademicPrograms() async {
    _academicPrograms = await _repository.getAll();
    notifyListeners();
  }

  Future<AcademicProgram?> getById(int id) async {
    return await _repository.getById(id);
  }
}
