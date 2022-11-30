import 'package:shared_preferences/shared_preferences.dart';

class User {
  static late User MY_USER;

  User({
    required this.id,
    required this.name,
    this.rollno,
    this.image,
    required this.email,
    required this.cnic,
    required this.no,
    this.address,
    required this.role,
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

  factory User.fromJson(Map<String, dynamic> json) {
    User temp = User(
      id: json["id"],
      name: json["name"],
      rollno: json["rollno"],
      image: json["image"],
      email: json["email"],
      cnic: json["cnic"],
      no: json["no"],
      address: json["address"],
      role: json["role"],
    );
    User.MY_USER = temp;
    return temp;
  }

  factory User.fromPrefs(SharedPreferences preferences) {
    return User(
        id: preferences.getInt('id')!,
        name: preferences.getString('name')!,
        rollno: preferences.getString('rollno')!,
        image: preferences.getString('image')!,
        email: preferences.getString("email")!,
        cnic: preferences.getString("cnic")!,
        no: preferences.getString("no")!,
        role: preferences.getString("role")!);
  }
}
