class AcademicProgram {
  final int id;
  final String name;

  AcademicProgram({required this.id, required this.name});

  factory AcademicProgram.fromJson(Map<String, dynamic> json) {
    return AcademicProgram(
      id: json['id'],
      name: json['name'],
    );
  }
}