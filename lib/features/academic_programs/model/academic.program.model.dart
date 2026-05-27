import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<AcademicProgram> academicProgram;

  Welcome({required this.academicProgram});

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    academicProgram: List<AcademicProgram>.from(
      json["academic_program"].map((x) => AcademicProgram.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "academic_program": List<dynamic>.from(
      academicProgram.map((x) => x.toJson()),
    ),
  };
}

class AcademicProgram {
  int id;
  String name;

  AcademicProgram({required this.id, required this.name});

  factory AcademicProgram.fromJson(Map<String, dynamic> json) =>
      AcademicProgram(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
