// To parse this JSON data, do
//
//     final studentAttempPaperModel = studentAttempPaperModelFromJson(jsonString);

import 'dart:convert';

StudentAttempPaperModel studentAttempPaperModelFromJson(String str) => StudentAttempPaperModel.fromJson(json.decode(str));

String studentAttempPaperModelToJson(StudentAttempPaperModel data) => json.encode(data.toJson());

class StudentAttempPaperModel {
  StudentAttempPaperModel({
   required this.id,
    required  this.marks,
    required  this.time,
    required   this.status,
    required   this.subjectId,
    required  this.sessionId,
    required   this.techerId,
    required  this.createdAt,
    required  this.updatedAt,
    required   this.subject,
    required   this.session,
    this.teacher,
    required   this.mcqs,
    required  this.tfs,
    required this.theories,
  });

  int id;
  String marks;
  String time;
  String status;
  int subjectId;
  int sessionId;
  int techerId;
  DateTime createdAt;
  DateTime updatedAt;
  Subject subject;
  Session session;
  dynamic teacher;
  List<Mcq> mcqs;
  List<dynamic> tfs;
  List<Theory> theories;

  factory StudentAttempPaperModel.fromJson(Map<String, dynamic> json) => StudentAttempPaperModel(
    id: json["id"],
    marks: json["marks"],
    time: json["time"],
    status: json["status"],
    subjectId: json["subject_id"],
    sessionId: json["session_id"],
    techerId: json["techer_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    subject: Subject.fromJson(json["subject"]),
    session: Session.fromJson(json["session"]),
    teacher: json["teacher"],
    mcqs: List<Mcq>.from(json["mcqs"].map((x) => Mcq.fromJson(x))),
    tfs: List<dynamic>.from(json["tfs"].map((x) => x)),
    theories: List<Theory>.from(json["theories"].map((x) => Theory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "marks": marks,
    "time": time,
    "status": status,
    "subject_id": subjectId,
    "session_id": sessionId,
    "techer_id": techerId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "subject": subject.toJson(),
    "session": session.toJson(),
    "teacher": teacher,
    "mcqs": List<dynamic>.from(mcqs.map((x) => x.toJson())),
    "tfs": List<dynamic>.from(tfs.map((x) => x)),
    "theories": List<dynamic>.from(theories.map((x) => x.toJson())),
  };
}

class Mcq {
  Mcq({
    required  this.id,
    required   this.statement,
    required   this.a,
    required   this.b,
    required   this.c,
    required    this.d,
    required    this.answer,
    required    this.marks,
    required   this.time,
    required   this.paperId,
    required    this.createdAt,
    required    this.updatedAt,
  });

  int id;
  String statement;
  String a;
  String b;
  String c;
  String d;
  String answer;
  String marks;
  String time;
  String paperId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
    id: json["id"],
    statement: json["statement"],
    a: json["a"],
    b: json["b"],
    c: json["c"],
    d: json["d"],
    answer: json["answer"],
    marks: json["marks"],
    time: json["time"],
    paperId: json["paper_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "statement": statement,
    "a": a,
    "b": b,
    "c": c,
    "d": d,
    "answer": answer,
    "marks": marks,
    "time": time,
    "paper_id": paperId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Session {
  Session({
    required   this.id,
    required   this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Subject {
  Subject({
    required    this.id,
    required   this.name,
    required   this.code,
    required   this.creditHours,
    required   this.sessionId,
    required  this.createdAt,
    required   this.updatedAt,
  });

  int id;
  String name;
  String code;
  String creditHours;
  String sessionId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    creditHours: json["credit_hours"],
    sessionId: json["session_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "credit_hours": creditHours,
    "session_id": sessionId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Theory {
  Theory({
    required    this.id,
    required  this.statement,
    required   this.answer,
    required   this.marks,
    required   this.time,
    required   this.paperId,
    required   this.createdAt,
    required  this.updatedAt,
  });

  int id;
  String statement;
  String answer;
  String marks;
  String time;
  String paperId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Theory.fromJson(Map<String, dynamic> json) => Theory(
    id: json["id"],
    statement: json["statement"],
    answer: json["answer"],
    marks: json["marks"],
    time: json["time"],
    paperId: json["paper_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "statement": statement,
    "answer": answer,
    "marks": marks,
    "time": time,
    "paper_id": paperId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
