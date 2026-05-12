import 'dart:convert';

SubjectResponse subjectResponseFromJson(String str) => SubjectResponse.fromJson(json.decode(str));

String subjectResponseToJson(SubjectResponse data) => json.encode(data.toJson());

class SubjectResponse {
    List<Subject> subjects;

    SubjectResponse({
        required this.subjects,
    });

    factory SubjectResponse.fromJson(Map<String, dynamic> json) => SubjectResponse(
        subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    };
}

class Subject {
    int id; // Mantenido por convención de base de datos
    String code;
    String name;
    int credits;
    int hours;
    String knowledgeArea;

    Subject({
        required this.id,
        required this.code,
        required this.name,
        required this.credits,
        required this.hours,
        required this.knowledgeArea,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        credits: json["credits"],
        hours: json["hours"],
        knowledgeArea: json["knowledgeArea"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "credits": credits,
        "hours": hours,
        "knowledgeArea": knowledgeArea,
    };
}