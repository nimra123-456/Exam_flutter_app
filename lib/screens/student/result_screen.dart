import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/student_result_model.dart';
import 'package:exam_app/models/user.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isloading = false;
  var data;
  List<StudentResultModel> _listResult = [];
  dynamic argumentData = Get.arguments;
  @override
  void initState() {
    super.initState();
    checkResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Result"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: _isloading
                ? Center(child: CircularProgressIndicator())
                : _listResult.isEmpty
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     ResultCard(
                            //       title: "GPA",
                            //       gp: 3.5,
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: kDefaultPadding,
                            // ),
                            Table(
                              border: TableBorder.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid),
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(color: kGrayColor),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "C.Id",
                                              style: Styles.headlineBold5(),
                                            ),
                                          ),
                                          Expanded(
                                              child: Text("Course",
                                                  style:
                                                      Styles.headlineBold5())),
                                          Expanded(
                                              child: Text("GPA",
                                                  style:
                                                      Styles.headlineBold5())),
                                          Expanded(
                                              child: Text("Status",
                                                  style:
                                                      Styles.headlineBold5()))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _listResult.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                color: index % 2 == 0
                                                    ? kGrayColor
                                                        .withOpacity(0.2)
                                                    : Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 5.0,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                              _listResult[index]
                                                                  .subject
                                                                  .code
                                                                  .toString())),
                                                      Expanded(
                                                          child: Text(
                                                              _listResult[index]
                                                                  .subject
                                                                  .name)),
                                                      Expanded(
                                                          child: Text(gpaSubject(int
                                                                  .parse(_listResult[
                                                                          index]
                                                                      .mcqMarks) +
                                                              int.parse(
                                                                  _listResult[
                                                                          index]
                                                                      .tfMarks) +
                                                              int.parse(_listResult[
                                                                      index]
                                                                  .theoryMarks)))),
                                                      Expanded(
                                                          child: Text(
                                                              _listResult[index]
                                                                  .pstatus)),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Text(
                              "Note:",
                              style: Styles.headlineBold5(),
                            ),
                            Text(
                                "You have passed your semester successfully and promoted to next semester. Next classes  start date will be confirmed letter .")
                          ])));
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
      Uri.http(BASE_URL, 'api/studentResult', _queryParameters),
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

  String gpaSubject(grade) {
    if (grade > 50 && grade <= 51)
      return "2.1";
    else if (grade >= 52 && grade <= 53)
      return "2.2";
    else if (grade == 54)
      return "2.3";
    else if (grade >= 55 && grade <= 56)
      return "2.4";
    else if (grade == 57)
      return "2.5";
    else if (grade >= 58 && grade <= 59)
      return "2.6";
    else if (grade == 60)
      return "2.7";
    else if (grade == 61 || grade == 62)
      return "2.8";
    else if (grade == 63 || grade == 64)
      return "2.9";
    else if (grade == 65)
      return "3.0";
    else if (grade == 63 || grade == 64)
      return "2.9";
    else if (grade == 65)
      return "3.0";
    else if (grade == 63 || grade == 64)
      return "2.9";
    else if (grade == 65)
      return "3.0";
    else if (grade == 63 || grade == 64)
      return "2.9";
    else if (grade == 65)
      return "3.0";
    else if (grade == 63 || grade == 64)
      return "2.9";
    else if (grade == 65)
      return "3.0";
    else if (grade == 63 || grade == 64)
      return "2.9";
    else if (grade == 65)
      return "3.0";
    else if (grade == 66)
      return "3.1";
    else if (grade == 67 || grade == 68)
      return "3.2";
    else if (grade == 69)
      return "3.3";
    else if (grade == 70 || grade == 71)
      return "3.4";
    else if (grade == 72)
      return "3.5";
    else if (grade == 73 || grade == 74)
      return "3.6";
    else if (grade == 75)
      return "3.7";
    else if (grade == 76 || grade == 77)
      return "3.8";
    else if (grade == 78 || grade == 79)
      return "3.9";
    else if (grade >=80 && grade<=100)
      return "4.0";
    else
      return "Fail";
  }
}
