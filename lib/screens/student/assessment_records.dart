import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/student_result_model.dart';
import 'package:exam_app/models/user.dart';

class AssessmentRecord extends StatefulWidget {
  const AssessmentRecord({Key? key}) : super(key: key);

  @override
  _AssessmentRecordState createState() => _AssessmentRecordState();
}

class _AssessmentRecordState extends State<AssessmentRecord> {
  bool _isloading = false;
  var data;
  List<StudentResultModel> _listResult = [];
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asessment Test"),
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
                  itemCount: _listResult.length,
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        "Subject:\t" +
                                            "${_listResult[index].subject.name}",
                                        style: Styles.headlineBold5()),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Code:\t" +
                                            "${_listResult[index].subject.code}",
                                        style: Styles.headlineBold5()),
                                  ),
                                ],
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
                                        "MCQ\'s Marks :\t" +
                                            "${_listResult[index].mcqMarks}",
                                        style: Styles.headline6()),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("True-False :\t",
                                            style: Styles.headline6()),
                                        Text("${_listResult[index].tfMarks}",
                                            style: Styles.headline6()),
                                      ],
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
                                        "Theory Marks :\t" +
                                            "${_listResult[index].theoryMarks}",
                                        style: Styles.headline6()),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Total Obt :\t",
                                            style: Styles.headline6()),
                                        Text(
                                          (int.parse(_listResult[index]
                                                      .mcqMarks) +
                                                  int.parse(_listResult[index]
                                                      .tfMarks) +
                                                  int.parse(_listResult[index]
                                                      .theoryMarks))
                                              .toString(),
                                          style: Styles.headline6(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Student Status :",
                                    style: Styles.headlineBold6(),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("${_listResult[index].pstatus}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: _listResult[index].pstatus ==
                                                  "Pass"
                                              ? Colors.green
                                              : Colors.red)),
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

  Future<List<StudentResultModel>> checkResult() async {
    setState(() {
      _isloading = true;
    });

    final Map<String, String> _queryParameters = <String, String>{
      'student_id': User.MY_USER.id.toString(),
      'session_id': argumentData[0],
    };

    var response = await http.get(
      Uri.http(BASE_URL, '/api/studentResult', _queryParameters),
    );
    if (json.decode(response.body)["status"] == 1) {
      data = jsonDecode(response.body)["data"];

      setState(() {
        _listResult = studentResultModelFromJson(data);
        _isloading = false;
      });
    } else {
      ExamRepo.showSnack(context, "Error occured");
    }
    return studentResultModelFromJson(data);
  }
}
