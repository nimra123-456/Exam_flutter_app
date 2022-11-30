import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/models/teacher_student_result.dart';

class ManageResult extends StatefulWidget {
  const ManageResult({Key? key}) : super(key: key);

  @override
  _ManageResultState createState() => _ManageResultState();
}

class _ManageResultState extends State<ManageResult> {
  final todos = <String>[];
  final controller = TextEditingController();
  late StudentResult students_result;
  dynamic argumentData = Get.arguments;
  bool isLoading = false;

  @override
  void initState() {
    evaluteResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Result"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : students_result.results.isEmpty
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _expandedRow("Subject",
                                "${students_result.results[0].subject.name}"),
                            _expandedRow("Total Students",
                                "${students_result.totalResults}"),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: [
                            _expandedRow(
                                "Total Pass", "${students_result.passResults}"),
                            _expandedRow(
                                "Total Fail", "${students_result.failResults}"),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                        Table(
                          border: TableBorder.all(
                              color: Colors.black, style: BorderStyle.solid),
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
                                          "RollNo",
                                          style: Styles.headlineBold5(),
                                        ),
                                      ),
                                      Expanded(
                                          child: Text("Name",
                                              style: Styles.headlineBold5())),
                                      Expanded(
                                          child: Text("Marks",
                                              style: Styles.headlineBold5())),
                                      Expanded(
                                          child: Text("Status",
                                              style: Styles.headlineBold5()))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: students_result.results.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            color: index % 2 == 0
                                                ? kGrayColor.withOpacity(0.2)
                                                : Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 5.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                          "${students_result.results[index].student.rollno}")),
                                                  Expanded(
                                                      child: Text(
                                                          "${students_result.results[index].student.name}")),
                                                  Expanded(
                                                      child: Text(
                                                          "${students_result.results[index].total}")),
                                                  Expanded(
                                                      child: Text(
                                                          "${students_result.results[index].pstatus}")),
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
                      ],
                    ),
                  ),
      ),
    );
  }

  Expanded _expandedRow(String title, String number) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            child: Text(
              "$title : ",
              style: Styles.headlineBold6(),
            ),
          ),
          Expanded(child: Text("$number")),
        ],
      ),
    );
  }

  Future<StudentResult> evaluteResult() async {
    setState(() {
      isLoading = true;
    });
    final Map<String, String> _queryParameters = <String, String>{
      'subject_id': argumentData[1],
      "session_id": argumentData[0],
    };

    var response = await http.get(Uri.http(
        BASE_URL, 'api/allCheckedPapers', _queryParameters));
    if (response.statusCode == 200) {
      students_result =
          StudentResult.fromJson(jsonDecode(response.body)["data"]);
      print(students_result.toString());
      setState(() {
        isLoading = false;
      });
    }
    return students_result;
  }
}
