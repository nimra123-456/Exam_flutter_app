import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/user.dart';

class TheoryScreen extends StatefulWidget {
  const TheoryScreen({Key? key}) : super(key: key);

  @override
  _TheoryScreenState createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  dynamic argumentData = getx.Get.arguments;
  List PaperQuestions = [];
  TextEditingController question = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theory Paper"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: question,
                  cursorColor: kColor,
                  maxLines: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Question";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Enter Question Statement ...",
                      hintStyle: Styles.headlineBold5(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                     style:ElevatedButton.styleFrom( backgroundColor: kGreenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),),
                      onPressed: () {
                        var productMap = {
                          'statement': question.text,
                          'answer': question.text,
                        };
                        PaperQuestions.add(productMap);
                        setState(() {
                          question.clear();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                       style:ElevatedButton.styleFrom( backgroundColor: kColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),),
                      onPressed: () {
                        if (PaperQuestions.length != 0) {
                          uploadQuestions();
                        } else {
                          ExamRepo.showSnack(context, "No Question Added");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  uploadQuestions() async {
    var formData = FormData.fromMap({
      "session_id": argumentData[0]['first'],
      "subject_id": argumentData[1]['second'],
      "marks": argumentData[2]['third'],
      "time": argumentData[3]['fourth'],
      "teacher_id": User.MY_USER.id.toString(),
      "theory": PaperQuestions
    });
    var response = await Dio()
        .post(API_BASE_URL + "save-paper", data: formData)
        .then((onResponse) async {
      if (onResponse.statusCode == 200) {
        PaperQuestions.clear();
        ExamRepo.showSnack(context, "paper successfully submitted");
      } else {
        ExamRepo.showSnack(context, "error occur");
      }
    }).onError((error, stackTrace) {
      ExamRepo.showSnack(context, "Paper Already Submitted");
    });
  }
}
