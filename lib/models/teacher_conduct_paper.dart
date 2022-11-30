

List<ConductPaperModel> conductPaperFromJson(List<dynamic> str) =>
    List<ConductPaperModel>.from(
        (str).map((x) => ConductPaperModel.fromJson(x)));

class ConductPaperModel {
  ConductPaperModel({
    required this.id,
    required this.marks,
    required this.time,
    required this.status,
    required this.subjectId,
    required this.sessionId,
    required this.techerId,
    required this.createdAt,
    required this.updatedAt,
    required this.mcqs,
    required this.tfs,
    required this.theories,
    required this.subject,
    required this.session,
    required this.teacher,
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
  List<dynamic> mcqs;
  List<dynamic> tfs;
  List<dynamic> theories;
  Session subject;
  Session session;
  Teacher teacher;

  factory ConductPaperModel.fromJson(Map<String, dynamic> json) =>
      ConductPaperModel(
        id: json["id"],
        marks: json["marks"],
        time: json["time"],
        status: json["status"],
        subjectId: json["subject_id"],
        sessionId: json["session_id"] ,
        techerId: json["techer_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mcqs: List<dynamic>.from(json["mcqs"].map((x) => x)),
        tfs: List<dynamic>.from(json["tfs"].map((x) => x)),
        theories: List<dynamic>.from(json["theories"].map((x) => x)),
        subject: Session.fromJson(json["subject"]),
        session: Session.fromJson(json["session"]),
        teacher: Teacher.fromJson(json["teacher"]),
      );
}

class Session {
  Session(
      {required this.id,
      required this.name,
      this.createdAt,
      this.updatedAt,
      this.code});

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
      code: json["code"]);
}

class Teacher {
  Teacher({
    required this.id,
    required this.name,
    this.rollno,
    this.image,
    required this.email,
    required this.cnic,
    required this.no,
    this.address,
    required this.role,
    this.emailVerifiedAt,
  });

  int id;
  String name;
  dynamic rollno;
  dynamic image;
  String email;
  String cnic;
  String no;
  dynamic address;
  String role;
  dynamic emailVerifiedAt;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
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
      );
}
