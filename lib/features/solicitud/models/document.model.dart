import 'dart:convert';

DocumentResponse documentResponseFromJson(String str) =>
    DocumentResponse.fromJson(json.decode(str));

String documentResponseToJson(DocumentResponse data) =>
    json.encode(data.toJson());

class DocumentResponse {
  List<AppDocument> documents;

  DocumentResponse({required this.documents});

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      DocumentResponse(
        documents: List<AppDocument>.from(
          json["documents"].map((x) => AppDocument.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class AppDocument {
  int id;
  String documentNumber;
  String type;
  String title;
  String content;
  int studentId;
  String sender;
  String receiver;
  String department;
  String status;
  String priority;
  DateTime createdAt;
  DateTime? approvalDate;
  String? attachmentUrl;

  AppDocument({
    required this.id,
    required this.documentNumber,
    required this.type,
    required this.title,
    required this.content,
    required this.studentId,
    required this.sender,
    required this.receiver,
    required this.department,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.approvalDate,
    this.attachmentUrl,
  });

  factory AppDocument.fromJson(Map<String, dynamic> json) => AppDocument(
    id: json["id"],
    documentNumber: json["documentNumber"],
    type: json["type"],
    title: json["title"],
    content: json["content"],
    studentId: json["studentId"],
    sender: json["sender"],
    receiver: json["receiver"],
    department: json["department"],
    status: json["status"],
    priority: json["priority"],
    createdAt: DateTime.parse(json["createdAt"]),
    approvalDate: json["approvalDate"] != null
        ? DateTime.parse(json["approvalDate"])
        : null,
    attachmentUrl: json["attachmentUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "documentNumber": documentNumber,
    "type": type,
    "title": title,
    "content": content,
    "studentId": studentId,
    "sender": sender,
    "receiver": receiver,
    "department": department,
    "status": status,
    "priority": priority,
    "createdAt":
        "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "approvalDate": approvalDate != null
        ? "${approvalDate!.year.toString().padLeft(4, '0')}-${approvalDate!.month.toString().padLeft(2, '0')}-${approvalDate!.day.toString().padLeft(2, '0')}"
        : null,
    "attachmentUrl": attachmentUrl,
  };
}
