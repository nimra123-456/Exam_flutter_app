// To parse this JSON data, do
//
//     final evaluatePaper = evaluatePaperFromJson(jsonString);



List<EvaluatePaperModel> evaluatePaperFromJson(List<dynamic> str) =>
    List<EvaluatePaperModel>.from(
        (str).map((x) => EvaluatePaperModel.fromJson(x)));

class EvaluatePaperModel {
  EvaluatePaperModel({
    required this.id,
    required this.mcqMarks,
    required this.tfMarks,
    required this.theoryMarks,
     this.file,
    required this.total,
    required this.status,
    this.pstatus,
    required this.paperId,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.subject,
    required this.session,
    required this.student,
  });

  int id;
  String mcqMarks;
  String tfMarks;
  String theoryMarks;
  dynamic file;
  String total;
  String status;
  dynamic pstatus;
  String paperId;
  String studentId;
  DateTime createdAt;
  DateTime updatedAt;
  Session subject;
  Session session;
  Student student;

  factory EvaluatePaperModel.fromJson(Map<String, dynamic> json) =>
      EvaluatePaperModel(
        id: json["id"],
        mcqMarks: json["mcq_marks"],
        tfMarks: json["tf_marks"],
        theoryMarks: json["theory_marks"],
        file: json["file"],
        total: json["total"],
        status: json["status"],
        pstatus: json["pstatus"],
        paperId: json["paper_id"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subject: Session.fromJson(json["subject"]),
        session: Session.fromJson(json["session"]),
        student: Student.fromJson(json["student"]),
      );
}

class Session {
  Session({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    required this.code,
  });

  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic code;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        code: json["code"],
      );
}

class Student {
  Student({
    required this.id,
    required this.name,
    this.rollno,
    required this.image,
    required this.email,
    required this.cnic,
    required this.no,
    this.address,
    required this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  dynamic rollno;
  String image;
  String email;
  String cnic;
  String no;
  dynamic address;
  String role;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        rollno: json["rollno"],
        image: json["image"],
        email: json["email"],
        cnic: json["cnic"],
        no: json["no"],
        address: json["address"],
        role: json["role"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
