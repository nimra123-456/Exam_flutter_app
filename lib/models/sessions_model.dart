// To parse this JSON data, do
//
//     final sessions = sessionsFromJson(jsonString);

List<Sessions> sessionsFromJson(List<dynamic> str) =>
    List<Sessions>.from((str).map((x) => Sessions.fromJson(x)));

class Sessions {
  Sessions({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Sessions.fromJson(Map<String, dynamic> json) => Sessions(
        id: json["id"],
        name: json["name"],
      );
}
