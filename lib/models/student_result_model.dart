// To parse this JSON data, do
//
//     final studentResultModel = studentResultModelFromJson(jsonString);

List<StudentResultModel> studentResultModelFromJson(List<dynamic> str) =>
    List<StudentResultModel>.from(
        (str).map((x) => StudentResultModel.fromJson(x)));

class StudentResultModel {
  StudentResultModel({
    required this.id,
    required this.mcqMarks,
    required this.tfMarks,
    required this.theoryMarks,
    this.file,
    required this.status,
    required this.pstatus,
    required this.total,
    required this.paperId,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
  });

  int id;
  String mcqMarks;
  String tfMarks;
  String theoryMarks;
  dynamic file;
  String status;
  String pstatus;
  String total;
  int paperId;
  int studentId;
  DateTime createdAt;
  DateTime updatedAt;
  Subject subject;

  factory StudentResultModel.fromJson(Map<String, dynamic> json) =>
      StudentResultModel(
        id: json["id"],
        mcqMarks: json["mcq_marks"],
        tfMarks: json["tf_marks"],
        theoryMarks: json["theory_marks"],
        file: json["file"],
        status: json["status"],
        pstatus: json["pstatus"],
        total: json["total"],
        paperId: json["paper_id"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subject: Subject.fromJson(json["subject"]),
      );
}

class Subject {
  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.sessionId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String code;
  int sessionId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        sessionId: json["session_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
