// To parse this JSON data, do
//
//     final subjects = subjectsFromJson(jsonString);

import 'dart:convert';

Subjects subjectsFromJson(String str) => Subjects.fromJson(json.decode(str));

String subjectsToJson(Subjects data) => json.encode(data.toJson());

class Subjects {
  Subjects({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
   required this.id,
    required   this.name,
    required   this.code,
    required  this.sessionId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String code;
  String sessionId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    sessionId: json["session_id"].toString(),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "session_id": sessionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
