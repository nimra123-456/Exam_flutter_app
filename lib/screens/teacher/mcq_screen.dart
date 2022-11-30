
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/user.dart';

class MCQScreen extends StatefulWidget {
  const MCQScreen({Key? key}) : super(key: key);

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  dynamic argumentData = getx.Get.arguments;
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  TextEditingController correct_option = TextEditingController();

  List PaperQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MCQ\'s Paper"),
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
                  maxLines: 5,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: option1,
                  cursorColor: kColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter option 1";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Option 1",
                      hintStyle: Styles.headline6(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: option2,
                  cursorColor: kColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Option 2";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Option 2 ",
                      hintStyle: Styles.headline6(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: option3,
                  cursorColor: kColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Option 3";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Option 3",
                      hintStyle: Styles.headline6(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: option4,
                  cursorColor: kColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Option 4";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Option 4",
                      hintStyle: Styles.headline6(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: correct_option,
                  cursorColor: kColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Correct Option ";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Correct Option ",
                      hintStyle: Styles.headline6(),
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
                          'a': option1.text,
                          'b': option2.text,
                          'c': option3.text,
                          'd': option4.text,
                          'answer': correct_option.text,
                        };
                        PaperQuestions.add(productMap);
                        setState(() {
                          clearFields();
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
      "mcq": PaperQuestions
    });
    await Dio()
        .post(API_BASE_URL + "save-paper", data: formData)
        .then((onResponse) async {
      if (onResponse.statusCode == 200) {
        PaperQuestions.clear();
        clearFields();
        ExamRepo.showSnack(context, "paper successfully submitted");
      } else {
        ExamRepo.showSnack(context, "error occur");
      }
    }).onError((error, stackTrace) {
      ExamRepo.showSnack(context, "Paper Already Submitted");
    });
  }

  clearFields() {
    question.clear();
    option1.clear();
    option2.clear();
    option3.clear();
    option4.clear();
    correct_option.clear();
  }
}
