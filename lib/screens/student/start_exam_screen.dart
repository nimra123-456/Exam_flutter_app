import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/controllers/student_exam_paper_controller.dart';
import 'package:exam_app/models/student_attempt_paper_model.dart';
import 'package:exam_app/screens/student/exam_tabs.dart';

class StartExam extends StatefulWidget {
  const StartExam({Key? key}) : super(key: key);

  @override
  State<StartExam> createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
  final controller = Get.put(ExamPaperController());
  dynamic argumentData = Get.arguments;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Start Exam"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FutureBuilder<StudentAttempPaperModel>(
                future: getExamPaper(),
                builder: (BuildContext context, snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Please wait its loading...'));
                  } else {
                    if (snapshot.hasError)
                      return Center(child: Text('Error: Paper not exists or deactived.'));
                    else
                      return Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.green,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Welcome to Exam System ",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                "Test your knowledge with our exam",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      snapshot.data!.status != "Active"
                                          ? Text(
                                              "No Active Exam Found",
                                              style: Styles.headlineBold6(),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                if (snapshot.data!.status !=
                                                    "Active") {
                                                } else {
                                                  controller.ExamList =
                                                      snapshot.data!;
                                                  Get.to(() => ExamTabs());
                                                }
                                              },
                                              child: Container(
                                                width: 120,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                    color: Colors.lightBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  "START",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ); // snapshot.data  :- get your object which is pass from your downloadData() function
                  }
                },
              )),
        ));
  }

  Future<StudentAttempPaperModel> getExamPaper() async {
    final Map<String, String> _queryParameters = <String, String>{
      'subject_id': argumentData[1],
      "session_id": argumentData[0],
    };
    var response = await http.get(
      Uri.http(
          BASE_URL, 'api/getSinglePaper', _queryParameters),
    );
    print('this is my paper ${response.body}');
    if (json.decode(response.body)["status"] == 1) {
   
    } else {
      ExamRepo.showSnack(context, json.decode(response.body)["message"]);
    }
    return StudentAttempPaperModel.fromJson(json.decode(response.body)["data"]);
    
  }
}
