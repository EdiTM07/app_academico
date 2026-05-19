import '../model/career.model.dart';

class CareerRepository {
  // Simulación
  final List<Career> _careers = [
    Career(id: 1, name: "Desarollo de Software"),
    Career(id: 2, name: "Electrónica"),
    Career(id: 3, name: "Administración"),
  ];

  List<Career> getAll() => _careers;
}
