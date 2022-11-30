import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/student_enrolled_course_model.dart';
import 'package:exam_app/models/user.dart';

class Subjects extends StatefulWidget {
  const Subjects({Key? key}) : super(key: key);

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  bool _isloading = false;
  var data;
  dynamic argumentData = Get.arguments;
  List<StudentEnrolledCourse> _listSubjects = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    checkResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enrolled Courses"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: _listSubjects.length,
                  itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: kGrayColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Course:\t" +
                                    "${_listSubjects[index].subject.name}",
                                style: Styles.headlineBold5(),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "ID:\t" +
                                          "${_listSubjects[index].subject.code}",
                                      style: Styles.headline5(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Dept:\t" + "CS",
                                      style: Styles.headline5(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Session:\t" +
                                          "${_listSubjects[index].session.name}",
                                      style: Styles.headline6(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Date:\t" +
                                            "${_listSubjects[index].time}",
                                        style: Styles.headline6()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
        ),
      ),
    );
  }

  Future<List<StudentEnrolledCourse>> checkResult() async {
    setState(() {
      _isloading = true;
    });

    final Map<String, String> _queryParameters = <String, String>{
      'student_id': User.MY_USER.id.toString(),
      'session_id': argumentData[0],
    };

    var response = await http.get(
      Uri.http(BASE_URL, 'api/allPapers', _queryParameters),
    );
    if (json.decode(response.body)["status"] == 1) {
      data = jsonDecode(response.body)["data"];

      setState(() {
        _listSubjects = studentEnrolledCourseFromJson(data);
        _isloading = false;
      });
    } else {
      ExamRepo.showSnack(context, "Error occured");
    }
    return studentEnrolledCourseFromJson(data);
  }
}
