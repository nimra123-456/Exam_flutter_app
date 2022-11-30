import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/teacher_conduct_paper.dart';

class ConductPaper extends StatefulWidget {
  const ConductPaper({Key? key}) : super(key: key);

  @override
  _ConductPaperState createState() => _ConductPaperState();
}

class _ConductPaperState extends State<ConductPaper> {
  dynamic argumentData = Get.arguments;
  bool Isloading = false;
  List<ConductPaperModel> paperList = [];

  @override
  initState() {
    getPaperList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Conduct Paper"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: paperList.length,
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
                                            "${paperList[index].subject.name}",
                                        style: Styles.headlineBold6()),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Session:\t" +
                                            "${paperList[index].session.name}",
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
                                            "${paperList[index].subject.code}",
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
                                          "${paperList[index].marks} ",
                                          style: Styles.bodyTextBold1(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Time :",
                                            style: Styles.headline6()),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("${paperList[index].time}",
                                            style: Styles.headline6()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        updatePaperStatus(
                                            paperList[index].status,
                                            paperList[index].id.toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: paperList[index].status ==
                                                    "Active"
                                                ? kGreenColor
                                                : kColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "${paperList[index].status}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
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

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm!"),
      content: Text("Are you sure?"),
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

  Future<List<ConductPaperModel>> getPaperList() async {
    setState(() {
      Isloading = true;
    });
    final Map<String, String> _queryParameters = <String, String>{
      'subject_id': argumentData[1],
      "session_id": argumentData[0],
    };

    var response = await http.get(
      Uri.http(BASE_URL, 'api/paper', _queryParameters),
    );
    if (response.statusCode == 200) {
      
      paperList = conductPaperFromJson(jsonDecode(response.body)['data']);

      setState(() {
        Isloading = false;
      });
    }
    return paperList;
  }

  updatePaperStatus(String status, paperId) async {
    final Map<String, String> _queryParameters = <String, String>{
      'status': status == "Active" ? "Deactive" : "Active",
    };

    var response = await http.put(
      Uri.http(
          BASE_URL, 'api/paper/edit/$paperId', _queryParameters),
    );
    if (response.statusCode == 200) {
      await getPaperList();
      ExamRepo.showSnack(context, json.decode(response.body)["message"]);
    }
  }
}
