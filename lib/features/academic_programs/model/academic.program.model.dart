import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    List<AcademicProgram> academicPrograms;

    Welcome({
        required this.academicPrograms,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        academicPrograms: List<AcademicProgram>.from(json["academic_programs"].map((x) => AcademicProgram.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "academic_programs": List<dynamic>.from(academicPrograms.map((x) => x.toJson())),
    };
}

class AcademicProgram {
    int id;
    String name;

    AcademicProgram({
        required this.id,
        required this.name,
    });

    factory AcademicProgram.fromJson(Map<String, dynamic> json) => AcademicProgram(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
