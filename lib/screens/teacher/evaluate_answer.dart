import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/evaluatepaper_model.dart';
import 'package:exam_app/screens/teacher/viewTheoryans.dart';

class EvaluateAnswer extends StatefulWidget {
  const EvaluateAnswer({Key? key}) : super(key: key);

  @override
  _EvaluateAnswerState createState() => _EvaluateAnswerState();
}

class _EvaluateAnswerState extends State<EvaluateAnswer> {
  String marks = "";
  List<EvaluatePaperModel> student_paperList = [];
  dynamic argumentData = Get.arguments;
  bool Isloading = false;

  @override
  void initState() {
    evaluteResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(argumentData[0]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Evaluate Paper"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Isloading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: student_paperList.length,
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
                                        "RollNo:\t" +
                                            "${student_paperList[index].student.rollno}",
                                        style: Styles.headlineBold6()),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Subj:\t" +
                                            "${student_paperList[index].subject.name}",
                                        style: Styles.bodyTextBold1()),
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
                                        "Code:\t" +
                                            "${student_paperList[index].subject.code}",
                                        style: Styles.headline6()),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Marks:\t",
                                          style: Styles.bodyTextBold1(),
                                        ),
                                        Text(
                                          "${student_paperList[index].total} ",
                                          style: Styles.bodyTextBold1(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {Get.to(()=>ViewTheoryAns(),arguments: student_paperList[index].file??"SKiped");},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: kColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "View",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showAlertDialog(
                                            context,
                                            student_paperList[index]
                                                .id
                                                .toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: kGreenColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Evaluate",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
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

  showAlertDialog(BuildContext context, String id) {
    // Create button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        updateTheoryMarks(id, marks);
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Evaluate Student!"),
      content: Container(
        height: 85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter obtained marks:"),
            SizedBox(height: 5),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Student marks";
                } else
                  return null;
              },
              decoration: InputDecoration(
                  fillColor: Color(
                    0x11304ffe,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  )),
              onChanged: (val) {
                setState(() {
                  marks = val;
                });
              },
            )
          ],
        ),
      ),
      actions: [
        okButton,
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<List<EvaluatePaperModel>> evaluteResult() async {
    setState(() {
      Isloading = true;
    });
    final Map<String, String> _queryParameters = <String, String>{
      'subject_id': argumentData[1],
      "session_id": argumentData[0],
    };

    var response = await http.get(Uri.http(
        BASE_URL, 'api/allSubmitPapers', _queryParameters));
    print(response.body);
    if (response.statusCode == 200) {
      student_paperList =
          evaluatePaperFromJson(jsonDecode(response.body)["data"]);
      print(student_paperList);
      setState(() {
        Isloading = false;
      });
    }
    return student_paperList;
  }

  updateTheoryMarks(String resultId, String marksObt) async {
    final Map<String, String> _queryParameters = <String, String>{
      'result_id': resultId,
      "theory_marks": marksObt,
    };

    var response = await http.post(Uri.parse(API_BASE_URL + "update-result"),
        body: _queryParameters);
    if (response.statusCode == 200) {
      evaluteResult();
    }
    ExamRepo.showSnack(context, json.decode(response.body)["message"]);
  }
}
