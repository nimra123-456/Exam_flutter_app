List<StudentNotifications> studentNotificationsFromJson(List<dynamic> str) =>
    List<StudentNotifications>.from(
        (str).map((x) => StudentNotifications.fromJson(x)));

class StudentNotifications {
  StudentNotifications({
    required this.id,
    required this.subject,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.time,
  });

  int id;
  String subject;
  int studentId;
  DateTime createdAt;
  DateTime updatedAt;
  String time;

  factory StudentNotifications.fromJson(Map<String, dynamic> json) =>
      StudentNotifications(
        id: json["id"],
        subject: json["subject"],
        studentId: json["student_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        time: json["time"],
      );
}
