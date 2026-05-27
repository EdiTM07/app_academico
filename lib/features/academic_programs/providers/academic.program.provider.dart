import 'package:flutter/material.dart';
import '../model/academic.program.model.dart';
import '../repository/academic.program.repository.dart';

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
