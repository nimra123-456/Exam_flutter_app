import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/models/sessions_model.dart';
import 'package:exam_app/models/student_notification_model.dart';
import 'package:exam_app/models/subjects_model.dart';
import 'package:exam_app/models/user.dart';

class Repository {
  static Future<List<Sessions>> getSessions() async {
    var data;
    var url = Uri.parse(API_BASE_URL + "sessions");
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      print('Failed to get sessions');
    }
    return sessionsFromJson(data);
  }

  static Future<Subjects> getSubjects(String classId) async {
    final Map<String, String> _queryParameters = <String, String>{
      'session_id': classId,
    };

    var response = await http.get(
      Uri.http(BASE_URL, 'api/show', _queryParameters),
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to get subjects');
    }
    return Subjects.fromJson(jsonDecode(response.body));
  }

  static Future<List<StudentNotifications>> getNotifications() async {
    final Map<String, String> _queryParameters = <String, String>{
      'student_id':User.MY_USER.id.toString() //'User.MY_USER.id.toString()',
    };

    var response = await http.get(
      Uri.http(
          BASE_URL, 'api/getNotification', _queryParameters),
    );
    if (json.decode(response.body)["status"] == 1) {
    } else {
      print("error");
    }
    return studentNotificationsFromJson(jsonDecode(response.body)["data"]);
  }

 static saveStudentPaper(
      String mcqs, String tf, String theory, String paperId) async {
    final Map<String, String> _queryParameters = <String, String>{
      'mcq_marks': mcqs,
      'file': theory,
      "tf_marks": tf,
      'paper_id': paperId,
      'student_id': User.MY_USER.id.toString()
    };
    print(_queryParameters);
    final response = await http.post(Uri.parse(API_BASE_URL + "result"),
        body: _queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"];
      Get.snackbar("Response!", jsonDecode(response.body)["message"]);
    } else {
      print('Failed to save paper');
    }
    Get.snackbar("Response!", jsonDecode(response.body)["message"]);
 }
}
