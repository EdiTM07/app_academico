import 'package:flutter/material.dart';
import '../model/career.model.dart';
import '../repository/career.repository.dart';

class CareerProvider extends ChangeNotifier {
  final CareerRepository _repository = CareerRepository();

  List<Career> _careers = [];
  List<Career> get careers => _careers;

  void loadCareers() {
    _careers = _repository.getAll();
    notifyListeners();
  }
}